import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/data/datasources/material_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/data/repositories/material_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/usecases/add_material_usercase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/usecases/liste_material_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/usecases/update_material_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);

  return MaterialDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);

  return MaterialRepositoryImpl(datasource: datasource);
});

final usecaseMaterialProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);

  return AddMaterialUsercase(repository: repository);
});

final listUsecaseMaterialProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);

  return ListeMaterialUsecase(repository: repository);
});

final updateUsecaseMaterialProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);

  return UpdateMaterialUsecase(repository: repository);
});
