import 'dart:convert';

import 'package:flutter_tdd_clean_architecture/data/http/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart';

import 'http_adapter_test.mocks.dart';

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

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late HttpAdapter sut;
  late MockClient client;
  late String url;

  setUp(() {
    client = MockClient();
    url = 'https://any_url';
    sut = HttpAdapter(client);
  });

  group('post', () {
    test('Should call post with correct values', () async {
      when(
        client.post(
          Uri.parse(url),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(client.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: '{"any_key":"any_value"}',
      ));
    });

    test('Should call post without body', () async {
      when(client.post(
        Uri.parse(url),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(
        url: url,
        method: 'post',
      );

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });

    test('Should return data if post returns 200', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('', 200));

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, isNull);
    });
  });
}
