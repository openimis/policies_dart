class ResourceServer {
  final String server;
  final String _baseUrl;

  ResourceServer(this.server, this._baseUrl);

  Uri getResourceUri(String resource, [Map<String,dynamic>? queryParameters]) =>
      Uri(scheme: "https", host: server, path: "$_baseUrl/$resource", queryParameters: queryParameters ?? {});
}
