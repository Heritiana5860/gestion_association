import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/repositories/member_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/member_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return MemberRepositoryImpl(datasource: datasource);
});

final memberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return MemberUsecase(repository: repository);
});
