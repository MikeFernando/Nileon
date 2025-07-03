import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'remote_authentication_test.mocks.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required String url});
}

@GenerateMocks([HttpClient])
void main() {
  test('should call HttpClient with correct URL', () async {
    final url = faker.internet.httpUrl();
    final httpClient = MockHttpClient();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    when(httpClient.request(url: url)).thenAnswer((_) async {});

    await sut.auth();

    verify(httpClient.request(url: url));
  });
}
