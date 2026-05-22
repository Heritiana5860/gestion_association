import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = "Identifiants ou mot de passe incorrects.",
  });
}
