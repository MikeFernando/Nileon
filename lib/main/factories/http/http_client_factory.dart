import 'package:http/http.dart';

import 'package:nileon/data/http/http.dart';
import 'package:nileon/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
