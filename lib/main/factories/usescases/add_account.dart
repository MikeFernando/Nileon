import 'package:nileon/data/usecases/usecases.dart';
import 'package:nileon/domain/usecases/usecases.dart';

import '../http/http.dart';

AddAccount makeRemoteAddAccount() {
  final httpClient = makeHttpAdapter();
  final addAccount = RemoteAddAccount(
    httpClient: httpClient,
    url: makeApiUrl('signup'),
  );

  return addAccount;
}
