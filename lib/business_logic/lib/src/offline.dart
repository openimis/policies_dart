import 'dart:async';

import 'package:business_logic/business_logic.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';

class Offline {
  final StreamController<int> queueLengthStream = StreamController.broadcast();
  final FhirClient _client;
  Database? _database;
  BusinessLogic? _bl;

  Offline._create(this._database, this._client);
  Offline._disabled(this._client) {
    _database = null;
  }

  void _startOfflineQueue() {
    bool queueRunning = false;
    _saveInsureesFromQueue(); // fire immediately at beginning
    Timer.periodic(
      Duration(seconds: 30),
      (timer) async {
        if (queueRunning) {
          return;
        }
        queueRunning = true;
        await _saveInsureesFromQueue();
        queueRunning = false;
      },
    );
  }

  static Future<Offline> create(FhirClient client) async {
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.macOS) {
      return Offline._disabled(client);
    }

    final database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE openimis_patient_queue(' +
            'server VARCHAR NOT NULL,' +
            'username VARCHAR NOT NULL,' +
            'insuranceId VARCHAR PRIMARY KEY,' +
            'lastName VARCHAR NOT NULL,' +
            'firstName VARCHAR NOT NULL,' +
            'groupid VARCHAR,' +
            'isHead INTEGER NOT NULL,' +
            'gender VARCHAR NOT NULL,' +
            'birthDate VARCHAR NOT NULL,' +
            'addressLocationId VARCHAR)');
      },
      version: 1,
    );

    final offline = Offline._create(database, client);
    offline._startOfflineQueue();
    return offline;
  }

  setBusinessLogic(BusinessLogic bl) {
    _bl = bl;
  }

  // inserts insuree to database queue
  Future<void> addInsureeToQueue(String insuranceId,
      Map<String, String> insuree, String? locationId, bool isHead) async {
    if (_database == null) {
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final OpenImisPatientQueue insureeQueue = OpenImisPatientQueue(
      server: _client.getServerName(),
      username: prefs.getString('username') ?? '',
      insuranceId: insuranceId,
      lastName: insuree["lastName"].toString(),
      firstName: insuree["firstName"].toString(),
      groupid: insuree["groupid"].toString(),
      isHead: isHead ? 1 : 0,
      gender: insuree["gender"].toString(),
      birthDate: insuree["birthDate"].toString(),
      addressLocationId: locationId,
    );
    await _database!.insert(
      'openimis_patient_queue',
      insureeQueue.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // tries to save persisted insurees from queue and deletes them from the queue
  Future<void> _saveInsureesFromQueue() async {
    if (_database == null) {
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username') ?? '';
    final List<Map<String, dynamic>>? patients = await _database!.query(
        'openimis_patient_queue',
        where: 'username = ?',
        whereArgs: [username]);

    queueLengthStream.add(patients?.length ?? 0);

    if (patients == null) {
      return;
    }

    if (_bl == null) {
      throw Exception("BusinessLogic not set!");
    }

    for (var patient in patients) {
      if (patient['server'] != _client.getServerName() ||
          patient['username'] != prefs.getString('username')) {
        continue;
      }
      try {
        String locationId =
            patient['addressLocationId'] ?? await _bl!.getFirstLocationId();
        bool isHead = patient['isHead'] == 1;
        await _bl!
            .saveInsuree(patient['insuranceId'], patient, locationId, isHead);
        await _database!.delete('openimis_patient_queue',
            where: 'insuranceId = ?', whereArgs: [patient['insuranceId']]);
      } on NoConnectionException {
        // stop queue execution if we can not contact the server
        break;
      } catch (e) {
        print(e);
        await _database!.delete('openimis_patient_queue',
            where: 'insuranceId = ?', whereArgs: [patient['insuranceId']]);
      }
    }

    queueLengthStream.add(patients.length);
  }
}

class OpenImisPatientQueue {
  final String? server;
  final String? username;
  final String? insuranceId;
  final String? lastName;
  final String? firstName;
  final String? groupid;
  final int? isHead;
  final String? gender;
  final String? birthDate;
  final String? addressLocationId;

  const OpenImisPatientQueue({
    required this.server,
    required this.username,
    required this.insuranceId,
    required this.lastName,
    required this.firstName,
    required this.groupid,
    required this.isHead,
    required this.gender,
    required this.birthDate,
    this.addressLocationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'server': server,
      'username': username,
      'insuranceId': insuranceId,
      'lastName': lastName,
      'firstName': firstName,
      'groupid': groupid,
      'isHead': isHead,
      'gender': gender,
      'birthDate': birthDate,
      'addressLocationId': addressLocationId,
    };
  }

  @override
  String toString() {
    return 'OpenImisPatientQueue{' +
        'server: $server, ' +
        'username: $username, ' +
        'insuranceId: $insuranceId, ' +
        'lastName: $lastName, ' +
        'firstName: $firstName, ' +
        'groupid: $groupid, ' +
        'isHead: $isHead, ' +
        'gender: $gender, ' +
        'birthDate: $birthDate, ' +
        'addressLocationId: $addressLocationId}';
  }
}
