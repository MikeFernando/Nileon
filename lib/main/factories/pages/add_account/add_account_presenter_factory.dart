import '../../../../presentation/presenters/stream_add_account_presenter.dart';
import '../../../../ui/pages/add_account/add_account_presenter.dart';

import '../../usescases/add_account.dart';
import 'add_account_validation_factory.dart';

AddAccountPresenter makeStreamAddAccountPresenter() {
  return StreamAddAccountPresenter(
    addAccountUseCase: makeRemoteAddAccount(),
    validation: makeAddAccountValidation(),
  );
}
