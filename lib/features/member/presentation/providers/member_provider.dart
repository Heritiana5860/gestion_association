import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/repositories/member_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/add_member_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/delete_member_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/detail_member_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/member_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/update_member_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return MemberRepositoryImpl(datasource: datasource);
});

final memberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return MemberUsecase(repository: repository);
});

final addMemberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return AddMemberUsecase(repository: repository);
});

final updateMemberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return UpdateMemberUsecase(repository: repository);
});

final detailMemberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return DetailMemberUsecase(repository: repository);
});

final deleteMemberUsecaseProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return DeleteMemberUsecase(repository: repository);
});
