abstract class LoginPresenter {
  void validateEmail(String email);
  void validatePassword(String password);
}

class LoginPresenterImpl implements LoginPresenter {
  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}
}
