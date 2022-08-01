import 'dart:convert';

import 'package:http/http.dart';
import 'package:crypto/crypto.dart';

class HTTPCache {
  final bool useCache = true;

  final cachedResponses = <String, Response>{};

  Future<Response> send(Request request) async {
    if (request.method == "get") {
      final hash = _getHash(request);
      if (cachedResponses.containsKey(hash)) {
        return cachedResponses[hash]!;
      }

      final streamResponse =
          await request.send().timeout(Duration(seconds: 10));
      final response = await Response.fromStream(streamResponse);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        cachedResponses[hash] = response;
      }
      return response;
    }

    return await Response.fromStream(await request.send());
  }

  String _getHash(Request request) {
    final content = [
      request.url.toString(),
      request.method.toString(),
    ].join(':');
    return md5.convert(utf8.encode(content)).toString();
  }
}
