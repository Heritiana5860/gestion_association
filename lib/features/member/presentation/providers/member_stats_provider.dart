import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/repositories/member_stats_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/member_stats_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberStatsDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return MemberStatsRepositoryImpl(datasource: datasource);
});

final memberStatsUsecase = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return MemberStatsUsecase(repository: repository);
});
