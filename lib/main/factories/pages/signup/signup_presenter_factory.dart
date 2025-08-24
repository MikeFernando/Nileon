import '../../../../presentation/presenters/stream_signup_presenter.dart';
import '../../../../ui/pages/signup/signup_presenter.dart';

import '../../usescases/add_account.dart';
import '../signup/signup_validation_factory.dart';

SignUpPresenter makeStreamSignUpPresenter() {
  return StreamSignUpPresenter(
    addAccount: makeRemoteAddAccount(),
    validation: makeAddAccountValidation(),
  );
}
