import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super(message: "Pas de connexion Internet.");
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({this.statusCode, required super.message});

  @override
  List<Object?> get props => [message, statusCode];
}

class AuthFailure extends Failure {
  const AuthFailure({
    super.message = "Session expirée, veuillez vous reconnecter.",
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
