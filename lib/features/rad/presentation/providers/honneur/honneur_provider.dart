import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/honneur_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/repositories/honneur_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/add_honneur_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/honneur_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/update_honneur_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return HonneurDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.read(datasourceProvider);
  return HonneurRepositoryImpl(datasource: datasource);
});

final usecaseHonneurProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return HonneurUsecase(repository: repository);
});

final usecaseAddHonneurProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return AddHonneurUsecase(repository: repository);
});

final usecaseUpdateHonneurProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return UpdateHonneurUsecase(repository: repository);
});
