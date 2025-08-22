import '../../../data/usecases/authentication/remote_authentication.dart';
import '../../../domain/usecases/usecases.dart';

import '../http/http.dart';

Authentication makeRemoteAuthentication() {
  final httpClient = makeHttpAdapter();
  final authentication = RemoteAuthentication(
    httpClient: httpClient,
    url: makeApiUrl('login'),
  );

  return authentication;
}
