import 'dart:io';
import 'package:fhir_openimis/src/resource_server.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'login.dart';
import 'login_exception.dart';

class Authenticator {
  final ResourceServer server;
  final String username;
  final String _password;

  Authenticator._internal(this.username, this._password, this.server);

  static Future<Authenticator> initialize(
      ResourceServer server, String username, String password) async {
    print('Authenticating with username: $username');
    final response = await sendLoginRequest(
        server.getResourceUri("login/"), username, password);
    if (response.statusCode != HttpStatus.ok) {
      throw LoginException(
          "HTTP-Error: ${response.statusCode}", response.statusCode);
    }
    return Authenticator._internal(username, password, server);
  }

  Future<Request> authenticate(Request request) async {
    List<int> bytes = utf8.encode('$username:$_password');
    request.headers["Authorization"] = base64Encode(bytes);
    return request;
  }
}
