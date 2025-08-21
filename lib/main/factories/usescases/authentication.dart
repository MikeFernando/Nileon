import 'package:nileon/data/usecases/remote_authentication.dart';
import 'package:nileon/domain/usecases/authentication.dart';
import 'package:nileon/main/factories/http/http_client_factory.dart';

Authentication makeRemoteAuthentication() {
  final httpClient = makeHttpAdapter();
  final url = 'https://api.example.com/login';
  final authentication = RemoteAuthentication(httpClient: httpClient, url: url);

  return authentication;
}
