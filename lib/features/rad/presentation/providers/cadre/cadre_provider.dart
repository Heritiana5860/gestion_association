import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/cadre_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/repositories/cadre_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/add_cadre_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/cadre_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/update_cadre_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return CadreDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.read(datasourceProvider);
  return CadreRepositoryImpl(datasource: datasource);
});

final usecaseCadreProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return CadreUsecase(repository: repository);
});

final usecaseAddCadreProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return AddCadreUsecase(repository: repository);
});

final usecaseUpdateCadreProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return UpdateCadreUsecase(repository: repository);
});