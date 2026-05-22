import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

class ServerError extends Failure {
  const ServerError() : super(message: "Erreur serveur.");
}
