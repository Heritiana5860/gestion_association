import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/datasources/add_obligation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/repositories/add_obligation_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/usecases/add_obligation_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AddObligationDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return AddObligationRepositoryImpl(datasource: datasource);
});

final usecaseAddObligationProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return AddObligationUsecase(repository: repository);
});
