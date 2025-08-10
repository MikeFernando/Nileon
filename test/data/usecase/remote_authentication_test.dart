import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'remote_authentication_test.mocks.dart';

import 'package:nileon/domain/usecases/usecases.dart';
import 'package:nileon/domain/helpers/helpers.dart';

import 'package:nileon/data/usecases/usecases.dart';
import 'package:nileon/data/http/http.dart';

@GenerateMocks([HttpClient])
void main() {
  late RemoteAuthentication sut;
  late MockHttpClient httpClient;
  late String url;
  late AuthenticationParams params;

  PostExpectation mockRequest() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ));

  Map mockValidData() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    mockHttpData(mockValidData());

    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
  });

  test('deve chamar HttpClient com valores corretos', () async {
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.password,
      },
    ));
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
    final accessToken = faker.guid.guid();

    mockHttpData({'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });

  test(
      'deve lançar UnexpectedError se HttpClient retornar 200 com dados inválidos',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
