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
    await client.post(url);
  }
}

@GenerateMocks([Client])
void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = MockClient();
      final url = Uri.parse('https://any_url');
      final sut = HttpAdapter(client);

      when(client.post(url)).thenAnswer((_) async => Response('', 200));

      await sut.request(url: url, method: 'post');

      verify(client.post(url));
    });
  });
}
