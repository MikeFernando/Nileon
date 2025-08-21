import 'package:nileon/presentation/presenters/stream_login_presenter.dart';

import 'login_validation_factory.dart';
import '../../usescases/authentication.dart';

StreamLoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
  );
}
