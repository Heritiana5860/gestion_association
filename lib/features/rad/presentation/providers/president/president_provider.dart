import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/president_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/repositories/president_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/add_president_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/president_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/update_president_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return PresidentDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.read(datasourceProvider);
  return PresidentRepositoryImpl(datasource: datasource);
});

final usecasePresidentProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return PresidentUsecase(repository: repository);
});

final usecaseAddPresidentProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return AddPresidentUsecase(repository: repository);
});

final usecaseUpdatePresidentProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return UpdatePresidentUsecase(repository: repository);
});
