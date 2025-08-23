import '../../../data/usecases/usecases.dart';

import '../../factories/factories.dart';

import '../http/http.dart';

RemoteAddAccount makeRemoteAddAccount() {
  final httpClient = makeHttpAdapter();
  final addAccount = RemoteAddAccount(
    httpClient: httpClient,
    url: makeApiUrl('add_account'),
  );

  return addAccount;
}
