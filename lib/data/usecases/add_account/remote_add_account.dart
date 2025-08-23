import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({required this.httpClient, required this.url});

  @override
  Future<AccountEntity> add(AddAccountParams params) async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAddAccountParams.fromDomain(params).toJson(),
      );

      if (httpResponse == null) {
        throw DomainError.unexpected;
      }

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.badRequest:
          throw DomainError.unexpected;
        case HttpError.unauthorized:
          throw DomainError.invalidCredentials;
        case HttpError.forbidden:
          throw DomainError.emailInUse;
        case HttpError.notFound:
          throw DomainError.unexpected;
        case HttpError.serverError:
          throw DomainError.unexpected;
        case HttpError.invalidData:
          throw DomainError.invalidEmail;
      }
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  RemoteAddAccountParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) {
    return RemoteAddAccountParams(
      name: params.name,
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
  }

  Map toJson() => {
        'nome': name,
        'email': email,
        'telefone': phone,
        'senha': password,
      };
}
