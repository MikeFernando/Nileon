import 'package:flutter/material.dart';
import 'package:nileon/ui/pages/signup/signup_page.dart';

import '../signup/signup_presenter_factory.dart';

Widget makeSignUpPage() {
  return SignUpPage(presenter: makeStreamSignUpPresenter());
}
