import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

class ValidationError extends Failure {
  const ValidationError(String message) : super(message: message);
}
