class ApiError implements Exception {
  final int statusCode;
  final String body;
  const ApiError(this.statusCode, this.body);

  @override
  String toString() {
    return "StatusCode: $statusCode\r\nResponse body: $body";
  }
}

class NoConnectionException implements Exception {
  final String cause;

  NoConnectionException(this.cause);
}
