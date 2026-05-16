import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/flutter_secure_storage_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_login_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/repositories/auth_login_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/usecases/auth_login_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthLoginDatasource(storage: storage, dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return AuthLoginRepositoryImpl(datasource: datasource);
});

final usecaseLoginProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return AuthLoginUsecase(repository: repository);
});
