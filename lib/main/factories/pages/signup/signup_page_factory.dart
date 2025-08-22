import 'package:flutter/material.dart';
import 'package:nileon/ui/pages/signup/signup_page.dart';

import 'signup_presenter_factory.dart';

Widget makeSignupPage() {
  return SignupPage(presenter: makeStreamSignupPresenter());
}
