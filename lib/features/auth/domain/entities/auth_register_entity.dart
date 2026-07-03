import 'package:equatable/equatable.dart';

class AuthRegisterEntity extends Equatable {
  final String fullName;
  final String username;
  final String password;

  const AuthRegisterEntity({
    required this.fullName,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, username, password];
}
