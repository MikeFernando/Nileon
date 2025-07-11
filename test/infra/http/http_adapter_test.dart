import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

import 'package:flutter_tdd_clean_architecture/data/http/http_error.dart';
import 'package:flutter_tdd_clean_architecture/infra/http/http.dart';

import 'http_adapter_test.mocks.dart';

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

  group('shared', () {
    test('Should throw InvalidData if invalid method is provided', () async {
      final future = sut.request(url: url, method: 'invalid_method');

      expect(future, throwsA(HttpError.invalidData));
    });
  });
  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(
      int statusCode, {
      String body = '{"any_key":"any_value"}',
    }) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() => mockResponse(200));

    test('Should call post with correct values', () async {
      mockResponse(200, body: '{"any_key":"any_value"}');

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
      mockResponse(200, body: '{"any_key":"any_value"}');

      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('Should return data if post returns 200', () async {
      mockResponse(200, body: '{"any_key":"any_value"}');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 204 with no data', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, isNull);
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.badRequest),
      );
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.unauthorized),
      );
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(403);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.forbidden),
      );
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(404);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.notFound),
      );
    });

    test('Should return ServerError if post returns 500', () async {
      mockResponse(500);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.serverError),
      );
    });

    test('Should return ServerError if post throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
