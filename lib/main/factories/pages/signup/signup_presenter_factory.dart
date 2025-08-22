import 'package:nileon/presentation/presenters/stream_signup_presenter.dart';
import 'package:nileon/ui/pages/signup/signup_presenter.dart';

import '../../usescases/add_account.dart';
import 'signup_validation_factory.dart';

SignupPresenter makeStreamSignupPresenter() {
  return StreamSignupPresenter(
    addAccount: makeRemoteAddAccount(),
    validation: makeSignupValidation(),
  );
}
