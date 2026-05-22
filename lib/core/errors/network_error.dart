import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

class NetworkError extends Failure {
  const NetworkError() : super(message: "Pas de connexion Internet.");
}
