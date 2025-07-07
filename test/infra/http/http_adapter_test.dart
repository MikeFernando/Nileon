import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required Uri url,
    required String method,
    Map? body,
    Encoding? encoding,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await client.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }
}

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late HttpAdapter sut;
  late MockClient client;
  late Uri url;

  setUp(() {
    client = MockClient();
    url = Uri.parse('https://any_url');
    sut = HttpAdapter(client);
  });

  group('post', () {
    test('Should call post with correct values', () async {
      when(client.post(url,
              headers: anyNamed('headers'),
              body: anyNamed('body'),
              encoding: anyNamed('encoding')))
          .thenAnswer((_) async => Response('', 200));

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
        encoding: null,
      );

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: '{"any_key":"any_value"}',
        encoding: anyNamed('encoding'),
      ));
    });

    test('Should call post without body', () async {
      when(client.post(
        url,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('', 200));

      await sut.request(
        url: url,
        method: 'post',
      );

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });
  });
}
