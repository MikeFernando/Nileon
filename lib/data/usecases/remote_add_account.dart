import '../../domain/entities/account_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/add_account.dart';

import '../http/http.dart';
import '../models/models.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({required this.httpClient, required this.url});

  @override
  Future<AccountEntity> add(SignupParams params) async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteSignupParams.fromDomain(params).toJson(),
      );

      if (httpResponse == null) {
        throw DomainError.unexpected;
      }

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.badRequest:
        case HttpError.unauthorized:
        case HttpError.forbidden:
        case HttpError.notFound:
        case HttpError.serverError:
        case HttpError.invalidData:
          throw DomainError.unexpected;
      }
    }
  }
}

class RemoteSignupParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  RemoteSignupParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory RemoteSignupParams.fromDomain(SignupParams params) {
    return RemoteSignupParams(
      name: params.name,
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
  }

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };
}
