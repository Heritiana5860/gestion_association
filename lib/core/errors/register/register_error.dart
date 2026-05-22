import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';

class RegisterError extends Failure {
  const RegisterError({required super.message});
}

class NetworkError extends RegisterError {
  const NetworkError() : super(message: "Pas de connexion Internet.");
}

class ServerError extends RegisterError {
  const ServerError() : super(message: "Erreur serveur.");
}

class ValidationError extends RegisterError {
  const ValidationError(String message) : super(message: message);
}
