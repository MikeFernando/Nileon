import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

import 'package:nileon/data/http/http_error.dart';
import 'package:nileon/infra/http/http.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://any_url'));
  });

  setUp(() {
    client = ClientSpy();
    url = 'https://any_url';
    sut = HttpAdapter(client);
  });

  group('compartilhado', () {
    test('Deve lançar InvalidData se método inválido for fornecido', () async {
      final future = sut.request(url: url, method: 'invalid_method');

      expect(future, throwsA(HttpError.invalidData));
    });
  });
  group('post', () {
    void mockResponse(
      int statusCode, {
      String body = '{"any_key":"any_value"}',
    }) {
      when(() => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      when(() => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(Exception());
    }

    setUp(() => mockResponse(200));

    test('Deve chamar post com valores corretos', () async {
      mockResponse(200, body: '{"any_key":"any_value"}');

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(() => client.post(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}',
          ));
    });

    test('Deve chamar post sem body', () async {
      mockResponse(200, body: '{"any_key":"any_value"}');

      await sut.request(url: url, method: 'post');

      verify(() => client.post(any(), headers: any(named: 'headers')));
    });

    test('Deve retornar dados se post retornar 200', () async {
      mockResponse(200, body: '{"any_key":"any_value"}');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Deve retornar null se post retornar 204 sem dados', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, isNull);
    });

    test('Deve retornar BadRequestError se post retornar 400', () async {
      mockResponse(400);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.badRequest),
      );
    });

    test('Deve retornar UnauthorizedError se post retornar 401', () async {
      mockResponse(401);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.unauthorized),
      );
    });

    test('Deve retornar ForbiddenError se post retornar 403', () async {
      mockResponse(403);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.forbidden),
      );
    });

    test('Deve retornar NotFoundError se post retornar 404', () async {
      mockResponse(404);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.notFound),
      );
    });

    test('Deve retornar ServerError se post retornar 500', () async {
      mockResponse(500);

      expect(
        () => sut.request(
          url: url,
          method: 'post',
        ),
        throwsA(HttpError.serverError),
      );
    });

    test('Deve retornar ServerError se post lançar exceção', () async {
      mockError();

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
