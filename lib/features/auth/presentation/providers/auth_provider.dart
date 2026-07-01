import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/flutter_secure_storage_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_local_datasource.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(storage: storage);
});
