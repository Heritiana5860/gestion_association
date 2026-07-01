import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/repositories/auth_login_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/usecases/auth_login_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/auth_provider.dart';

final remoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dio: dio);
});

final repositoryProvider = Provider<AuthLoginRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthLoginRepositoryImpl(local: local, remote: remote);
});

final usecaseLoginProvider = Provider<AuthLoginUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return AuthLoginUseCase(repository: repository);
});
