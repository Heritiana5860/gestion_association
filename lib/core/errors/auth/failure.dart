sealed class AuthFailure implements Exception {
  final String message;
  const AuthFailure(this.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
    : super("Identifiants ou mot de passe incorrects.");
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure()
    : super("Impossible de joindre le serveur. Vérifiez votre connexion.");
}

class ServerFailure extends AuthFailure {
  const ServerFailure() : super("Une erreur interne du serveur est survenue.");
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure(super.message);
}
