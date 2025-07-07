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
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await client.post(url, headers: headers);
  }
}

@GenerateMocks([Client])
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
      when(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      })).thenAnswer((_) async => Response('', 200));

      await sut.request(url: url, method: 'post');

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      }));
    });
  });
}
