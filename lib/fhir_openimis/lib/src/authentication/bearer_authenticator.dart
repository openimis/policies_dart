import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fhir_openimis/src/resource_server.dart';
import 'package:http/http.dart';

import 'login.dart';
import 'login_exception.dart';
import 'authenticator.dart';
import 'bearer_token.dart';

class BearerAuthenticator implements Authenticator {
  static const String _bearerHeaderPrefix = "Bearer ";

  @override
  final ResourceServer server;
  @override
  final String username;
  final String _password;

  BearerAuthenticator._internal(this.server, this.username, this._password);

  Completer<BearerToken>? _tokenCompleter;

  static BearerAuthenticator offline(
      ResourceServer server, String username, String password) {
    return BearerAuthenticator._internal(server, username, password);
  }

  static Future<BearerAuthenticator> initialize(
      ResourceServer server, String username, String password) async {
    BearerAuthenticator authenticator =
        BearerAuthenticator._internal(server, username, password);

    //Throws if the login fails
    await authenticator._getToken();

    return authenticator;
  }

  @override
  Future<Request> authenticate(Request request) async {
    BearerToken token = await _getToken();
    request.headers["Authorization"] = _bearerHeaderPrefix + token.getToken();
    return request;
  }

  Future<BearerToken> _getToken() async {
    BearerToken? currentToken = await _tokenCompleter?.future;
    if ((currentToken?.expiresIn() ?? 0) < 2) {
      //Reset on expiring token
      _tokenCompleter = null;
    }

    if (_tokenCompleter != null) {
      return _tokenCompleter!.future;
    }

    _tokenCompleter = Completer<BearerToken>();

    Response response = await sendLoginRequest(
        server.getResourceUri("login/"), username, _password);
    if (response.statusCode != HttpStatus.ok) {
      _tokenCompleter!.completeError(response.statusCode);
      _tokenCompleter = null;
      throw LoginException(
          "HTTP-Error: ${response.statusCode}", response.statusCode);
    }

    currentToken = BearerToken.fromJson(jsonDecode(response.body));

    if (!_tokenCompleter!.isCompleted) {
      _tokenCompleter!.complete(currentToken);
    }

    return _tokenCompleter!.future;
  }
}
