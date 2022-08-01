import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:business_logic/business_logic.dart';
import 'package:business_logic/src/offline.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';
import 'package:fhir_openimis/src/generated/code_systems/code_systems.dart';
import 'package:fhir_openimis/src/generated/abstracts/abstracts.dart';
import 'package:fhir_openimis/src/generated/base_types/base_types.dart';
import 'package:fhir_openimis/src/generated/code_systems/code_systems.dart';
import 'package:fhir_openimis/src/generated/extensions/extensions.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_patient/openimis_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessLogic {
  //codes and display names of medications and services
  static final Set<Eligibility> _cachedMedications = {};
  static final Set<Eligibility> _cachedServices = {};
  static final Set<OpenimisPatient> _cachedInsurees = {};

  final FhirClient _client;
  final String insurer;
  Offline offline;

  BusinessLogic._create(this._client, this.offline, this.insurer);

  Future<OpenimisPatient> _getPerson(String id) async {
    return await _client.getPatient(id);
  }

  static create(FhirClient client, String insurer) async {
    final offline = await Offline.create(client);
    final bl = BusinessLogic._create(client, offline, insurer);
    offline.setBusinessLogic(bl);
    return bl;
  }

  /**
   * Eligibilities
   */

  Stream<Set<Eligibility>> getAllEligibilities() {
    return StreamGroup.merge([
      _getAllMedications().map((event) => event),
      _getAllServices().map((event) => event)
    ]);
  }

  Stream<Set<Eligibility>> _getAllMedications() async* {
    Set<Eligibility> newMedications;
    int page = 1;
    yield _cachedMedications;
    do {
      try {
        newMedications = await _getMedicationPage(page++);
      } on ApiError catch (error) {
        //Will happen at the end of the stream, when an invalid page is requested
        print(error);
        break;
      }
      _cachedMedications.addAll(newMedications);
      yield _cachedMedications;
    } while (newMedications.isNotEmpty);
  }

  Future<Set<Eligibility>> _getMedicationPage(int page) async {
    Bundle<OpenimisMedication> medications =
        await _client.getMedications(pageOffset: page);

    if (medications.entry == null) {
      return {};
    }

    Set<Eligibility> result = {};
    for (Entry<OpenimisMedication> entry in medications.entry!) {
      OpenimisMedication? medication = entry.resource;
      if (medication?.code.text != null) {
        //Medications use the human readable text as code
        result.add(Eligibility(
            displayName: medication!.code.text!,
            code: medication.code.text!,
            isService: false));
      }
    }

    return result;
  }

  Stream<Set<Eligibility>> _getAllServices() async* {
    Set<Eligibility> services;
    int page = 1;
    yield _cachedServices;
    do {
      try {
        services = await _getServicePage(page++);
      } on ApiError catch (error) {
        //Will happen at the end of the stream, when an invalid page is requested
        print(error);
        break;
      }
      _cachedServices.addAll(services);
      yield services;
    } while (services.isNotEmpty);
  }

  Future<Set<Eligibility>> _getServicePage(int page) async {
    Bundle<OpenimisActivitiyDefinition> services =
        await _client.getMedicalServices(pageOffset: page);

    if (services.entry == null) {
      return {};
    }

    Set<Eligibility> result = {};
    for (Entry<OpenimisActivitiyDefinition> entry in services.entry!) {
      OpenimisActivitiyDefinition? service = entry.resource;
      if (service?.name != null) {
        //Map the human readable name to the code
        result.add(Eligibility(
            displayName: service!.title, code: service.name, isService: true));
      }
    }

    return result;
  }

  Future<bool> requestItemEligibility(
      String insureeId, Eligibility eligibility) async {
    OpenimisCoverageEligibilityResponse response =
        await _client.getCoverageEligibilityOfItem(
            insureeId: insureeId,
            insurer: insurer,
            eligibilityCode: eligibility.code,
            isService: eligibility.isService);

    for (Insurance insurance in response.insurance!) {
      DateTime now = DateTime.now();
      if (now.isBefore(insurance.benefitPeriod!.start!) ||
          now.isAfter(insurance.benefitPeriod!.end!)) {
        continue;
      }

      for (InsuranceItem item in insurance.item!) {
        print(item.toJson());
        //Item is valid if excluded is false
        return item.excluded?.isValid ?? false
            ? !(item.excluded!.value ?? true)
            : false;
      }
    }
    return false;
  }

  Future<bool> checkInsurance(String insureeId) async {
    OpenimisCoverageEligibilityResponse response =
        await _client.getCoverageEligibilityOfBenefits(
            insureeId: insureeId, insurer: insurer);

    for (Insurance insurance in response.insurance!) {
      DateTime now = DateTime.now();
      if (now.isBefore(insurance.benefitPeriod!.start!) ||
          now.isAfter(insurance.benefitPeriod!.end!)) {
        continue;
      }

      for (InsuranceItem item in insurance.item!) {
        print(item.toJson());
        // Insuree is ensured if they have any benefit item
        return true;
      }
    }

    return false;
  }

  Future<List<OpenimisPatient>> getPatients(
      [int page = 1, int amount = 10]) async {
    final patients =
        await _client.getPatients(amount: amount, pageOffset: page);
    List<OpenimisPatient> patientsList = [];
    patients.entry!.forEach((entry) {
      patientsList.add(entry.resource!);
    });
    return patientsList;
  }

  Stream<List<OpenimisPatient>> getAllInsurees() async* {
    List<OpenimisPatient> newInsurees;
    int page = 1;
    do {
      try {
        newInsurees = await getPatients(page);
        page += 1;
      } on ApiError catch (error) {
        //Will happen at the end of the stream, when an invalid page is requested
        print(error);
        break;
      }
      _cachedInsurees.addAll(newInsurees);
      yield _cachedInsurees.toList();
    } while (newInsurees.isNotEmpty);
  }

  List<OpenimisPatient> searchPatient(
      List<OpenimisPatient> insurees, String search,
      [int page = 1]) {
    final _search = search.toLowerCase();
    if (search.isEmpty) {
      return insurees.toList();
    }

    return insurees.where((patient) {
      final name =
          "${patient.name.first.given!.join(" ")} ${patient.name.first.family}"
              .toLowerCase();
      if (name.contains(_search)) {
        return true;
      }
      if (patient.id!.contains(_search) ||
          patient.identifier[1].value!.contains(_search)) {
        return true;
      }
      return false;
    }).toList();
  }

  Future<OpenimisPatient> getPerson(String id) async {
    return await _getPerson(id);
  }

  Future<OpenimisGroup> getFamily(String id) async {
    OpenimisGroup group = await _client.getFamily(id);

    return group;
  }

  Future<List<OpenimisPatient>> getFamilyMembers(String familyId) async {
    final family = await getFamily(familyId);

    var memberIds =
        family.member.map((member) => member.entity?.identifier?.value ?? "");

    // remove duplicates
    memberIds = memberIds.toSet().toList();

    final futures = <Future<OpenimisPatient>>[];
    for (String memberId in memberIds) {
      futures.add(_getPerson(memberId));
    }

    return await Future.wait(futures);
  }

  Future<OpenimisPatient> getFamilyHead(String familyId) async {
    final members = await getFamilyMembers(familyId);
    return members.firstWhere((member) => member.extension?.first != null);
  }

  Future<Bundle<OpenimisGroup>> getFamilies([int page = 1]) async {
    return await _client.getFamilies(pageOffset: page);
  }

  /**
   * Insuree
   */

  // creates the insuree and returns if it could saved
  Future<OpenimisPatient> createInsuree(Map<String, String> insuree) async {
    String randomId =
        "P${Random().nextInt(1000).toString()}"; // TODO check if id already exists

    bool isHead = insuree["groupid"].toString().length <=
        2; // TODO ids lower 99 are head of insurees?

    try {
      // TODO: use proper location
      final String locationId = await getFirstLocationId();
      return await saveInsuree(randomId, insuree, locationId, isHead);
    } on NoConnectionException {
      await offline.addInsureeToQueue(randomId, insuree, null, isHead);
      rethrow;
    }
  }

  Future<String> getFirstLocationId() async {
    final locations = await _client.getLocations();
    if (locations.entry?.isEmpty ?? false) {
      throw Exception("No locations found");
    }
    final String? locationId = locations.entry?[0].resource?.id;
    if (locationId == null) {
      throw Exception("No location found");
    }
    return locationId;
  }

  Future<OpenimisPatient> saveInsuree(String randomId,
      Map<String, dynamic> insuree, String locationId, bool isHead) async {
    final AdministrativeGenderCode gender;
    switch (insuree["gender"]) {
      case "male":
        gender = AdministrativeGenderCode.value_male;
        break;
      case "female":
        gender = AdministrativeGenderCode.value_female;
        break;
      case "other":
        gender = AdministrativeGenderCode.value_other;
        break;
      default:
        gender = AdministrativeGenderCode.value_unknown;
    }
    final OpenimisPatient patient = _client.createValidPatientResource(
        insuranceId: randomId,
        familyName: insuree["lastName"].toString(),
        givenName: insuree["firstName"].toString(),
        groupId: insuree["groupid"],
        isHead: isHead,
        gender: gender,
        birthDate: Date(insuree["birthDate"]),
        addressLocationId: locationId);

    return await _client.createPatient(patient);
  }
}
