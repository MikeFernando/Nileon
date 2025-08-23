import 'package:flutter/material.dart';
import 'package:nileon/ui/pages/add_account/add_account.dart';

import 'add_account_presenter_factory.dart';

Widget makeAddAccountPage() {
  return AddAccountPage(presenter: makeStreamAddAccountPresenter());
}
