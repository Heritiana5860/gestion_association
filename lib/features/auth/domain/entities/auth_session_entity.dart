import 'package:equatable/equatable.dart';

class AuthSessionEntity extends Equatable {
  final String refresh;
  final String access;
  final String username;
  final String firstName;

  const AuthSessionEntity({
    required this.refresh,
    required this.access,
    required this.username,
    required this.firstName,
  });

  @override
  List<Object?> get props => [refresh, access, username, firstName];
}
