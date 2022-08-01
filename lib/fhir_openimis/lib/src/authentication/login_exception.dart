class LoginException implements Exception {
  final String cause;
  final int? httpStatusCode;

  LoginException(this.cause, [this.httpStatusCode]);
}
