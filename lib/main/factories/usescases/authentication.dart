import 'package:nileon/data/usecases/usecases.dart';
import 'package:nileon/domain/usecases/usecases.dart';

import '../http/http.dart';

Authentication makeRemoteAuthentication() {
  final httpClient = makeHttpAdapter();
  final authentication = RemoteAuthentication(
    httpClient: httpClient,
    url: makeApiUrl('login'),
  );

  return authentication;
}
