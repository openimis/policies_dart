import 'dart:async';
import 'dart:io';

import 'package:fhir_openimis/src/api_error.dart';
import 'package:fhir_openimis/src/authentication/login_exception.dart';
import 'package:http/http.dart';
import 'package:fhir_openimis/src/http_method.dart';

Future<Response> sendLoginRequest(
    Uri loginUrl, String username, String password) async {
  Request loginRequest = Request(HttpMethod.post.name, loginUrl)
    ..headers.addAll({"Content-Type": "application/json"})
    ..body = '{"username":"$username","password":"$password"}';

  StreamedResponse responseStream;
  try {
    responseStream = await loginRequest.send().timeout(Duration(seconds: 10));
  } on SocketException catch (e) {
    throw NoConnectionException(e.toString());
  } on TimeoutException catch (e) {
    throw NoConnectionException(e.toString());
  }

  return await Response.fromStream(responseStream);
}
