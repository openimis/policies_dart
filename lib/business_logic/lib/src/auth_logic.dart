import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogic {
  static const String _usernamePrefKey = 'username';
  static const String _passwordPrefKey = 'password';
  static const String _timestampPrefKey = 'login_timestamp';
  static const Duration _savedCredentialValidityDuration = Duration(hours: 24);

  final List<ResourceServer> servers;
  final SharedPreferences _prefs;
  final StreamController<Authenticator?> _streamController;

  ResourceServer selectedServer;
  Credentials? _lastSuccessfulCredentials;
  Authenticator? _lastAuthenticator;

  AuthLogic(
      {required this.servers, required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences,
        // TODO: avoid crash if no servers are provided
        selectedServer = servers.firstWhere(
            (element) =>
                element.server == sharedPreferences.getString('server'),
            orElse: () => servers[0]),
        _streamController = StreamController.broadcast() {
    _streamController.add(null);
    _streamController.stream.listen((event) {
      _lastAuthenticator = event;
    });
  }

  Future<Authenticator> login(String username, String password) async {
    print(selectedServer.server);
    return await loginWithCredentials(Credentials(username, password));
  }

  Future<Authenticator> loginWithCredentials(Credentials credentials) async {
    if (_lastSuccessfulCredentials == credentials &&
        _lastAuthenticator != null) {
      return _lastAuthenticator!;
    }

    try {
      Authenticator auth = await BearerAuthenticator.initialize(
          selectedServer, credentials.username, credentials.password);
      _writeCredentialsToPreferences(credentials);
      _lastSuccessfulCredentials = credentials;
      _streamController.add(auth);
      return auth;
    } on LoginException catch (e) {
      _streamController.addError(e);
      _removeCredentials();
      rethrow;
    } on NoConnectionException {
      rethrow;
    } catch (e) {
      // Assuming connection issues, therefore not removing the credentials
      _streamController.addError(e);
      rethrow;
    }
  }

  void _removeCredentials() {
    _streamController.add(null);
    _lastSuccessfulCredentials = null;
    _prefs.remove(_usernamePrefKey);
    _prefs.remove(_passwordPrefKey);
  }

  //Split into an internal call for overriding purposes
  void logout() => _removeCredentials();

  Authenticator? getLastAuthenticator() => _lastAuthenticator;

  Stream<Authenticator?> getAuthenticatorStream() => _streamController.stream;

  String? getCurrentUsername() => _lastAuthenticator?.username;

  String? getCurrentAuthHost() =>
      _lastAuthenticator?.server.getResourceUri("").host;

  Credentials? loadCredentialsFromPreferences() {
    String? username = _prefs.getString(_usernamePrefKey);
    if (username == null) {
      return null;
    }

    String password = _prefs.getString(_passwordPrefKey)!;
    int timestamp = _prefs.getInt(_timestampPrefKey)!;

    if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(timestamp)
        .add(_savedCredentialValidityDuration))) {
      _removeCredentials();
      return null;
    }
    _lastSuccessfulCredentials =
        Credentials._internal(username, password, timestamp);

    if (_lastAuthenticator == null) {
      //Setup initial offline authenticator, while starting
      _streamController
          .add(BearerAuthenticator.offline(selectedServer, username, password));
    }

    return _lastSuccessfulCredentials;
  }

  void _writeCredentialsToPreferences(Credentials credentials) {
    _prefs.setInt(_timestampPrefKey, credentials.timestamp);
    _prefs.setString(_usernamePrefKey, credentials.username);
    _prefs.setString(_passwordPrefKey, credentials.password);
  }
}

class Credentials {
  final String username, password;
  final int timestamp;

  Credentials(this.username, this.password)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  Credentials._internal(this.username, this.password, this.timestamp);

  @override
  int get hashCode => hashValues(username, password);

  @override
  bool operator ==(Object other) {
    return other is Credentials &&
        other.runtimeType == runtimeType &&
        other.username == username &&
        other.password == password;
  }
}
