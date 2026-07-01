import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_register_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/repositories/auth_register_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/auth_provider.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRegisterDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRegisterRepositoryImpl(datasource: datasource, local: local);
});

final usecaseRegisterProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return AuthRegisterUsecase(repository: repository);
});
