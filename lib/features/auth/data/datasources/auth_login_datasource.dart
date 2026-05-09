import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';

class AuthLoginDatasource {
  final FlutterSecureStorage storage;

  const AuthLoginDatasource({required this.storage});

  Future<void> authSubmit({required AuthModel model}) async {}
}
