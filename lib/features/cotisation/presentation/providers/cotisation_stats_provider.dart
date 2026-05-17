import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/repositories/cotisation_stats_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/cotisation_stats_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return CotisationStatsDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return CotisationStatsRepositoryImpl(datasource: datasource);
});

final usecaseCotisationStatsProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return CotisationStatsUsecase(repository: repository);
});
