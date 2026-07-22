import 'package:equatable/equatable.dart';

class AuthRegisterEntity extends Equatable {
  final String fullName;
  final String username;
  final String password;
  final String? role;

  const AuthRegisterEntity({
    required this.fullName,
    required this.username,
    required this.password,
    this.role,
  });

  @override
  List<Object?> get props => [fullName, username, password, role];
}
