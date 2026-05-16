import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';

class AutorisationToken {
  const AutorisationToken._();

  static Future<Map<String, dynamic>> headers() async {
    final storage = FlutterSecureStorage();

    final token = await storage.read(key: TokenKey.token);

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }
}
