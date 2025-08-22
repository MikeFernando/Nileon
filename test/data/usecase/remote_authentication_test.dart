import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nileon/domain/usecases/usecases.dart';
import 'package:nileon/domain/helpers/helpers.dart';

import 'package:nileon/data/http/http.dart';
import 'package:nileon/data/usecases/authentication/remote_authentication.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  void mockHttpData(Map data) {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(error);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
  });

  test('deve chamar HttpClient com valores corretos', () async {
    final validData = {
      'id': faker.guid.guid(),
      'name': faker.person.name(),
      'email': faker.internet.email(),
      'phone': faker.phoneNumber.toString(),
    };
    mockHttpData(validData);

    await sut.auth(params);

    verify(
      () => httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.password,
        },
      ),
    );
  });

  test('deve lançar UnexpectedError se HttpClient retornar 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('deve lançar UnexpectedError se HttpClient retornar 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('deve lançar UnexpectedError se HttpClient retornar 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('deve lançar UnexpectedError se HttpClient retornar 401', () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('deve retornar uma Account se HttpClient retornar 200', () async {
    final mockData = {
      'id': faker.guid.guid(),
      'name': faker.person.name(),
      'email': faker.internet.email(),
      'phone': faker.phoneNumber.toString(),
    };
    mockHttpData(mockData);

    final account = await sut.auth(params);

    expect(account.id, mockData['id']);
    expect(account.name, mockData['name']);
    expect(account.email, mockData['email']);
    expect(account.phone, mockData['phone']);
  });

  test(
      'deve lançar UnexpectedError se HttpClient retornar 200 com dados inválidos',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
