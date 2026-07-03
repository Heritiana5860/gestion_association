import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/repositories/cotisation_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/add_cotisation_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/get_cotisation_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return CotisationDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return CotisationRepositoryImpl(datasource: datasource);
});

final usecaseCotisationsProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return GetCotisationUsecase(repository: repository);
});

final usecaseAddCotisationsProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return AddCotisationUsecase(repository: repository);
});
