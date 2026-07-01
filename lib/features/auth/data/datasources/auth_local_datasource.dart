import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(AuthSessionModel session);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  const AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> saveToken(AuthSessionModel session) async {
    await Future.wait([
      storage.write(key: TokenKey.tokenAccess, value: session.access),
      storage.write(key: TokenKey.refresh, value: session.refresh),
    ]);
  }
}
