import 'dart:convert';
import 'package:http/http.dart';

import '../../data/http/http_client.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map?> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.body.isEmpty) {
      return null;
    }
    return jsonDecode(response.body);
  }
}
