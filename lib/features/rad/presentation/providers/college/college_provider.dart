import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/college_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/repositories/college_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/add_college_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/college_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/update_college_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return CollegeDatasourceImpl(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.read(datasourceProvider);
  return CollegeRepositoryImpl(datasource: datasource);
});

final usecaseCollegeProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return CollegeUsecase(repository: repository);
});

final usecaseAddCollegeProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return AddCollegeUsecase(repository: repository);
});

final usecaseUpdateCollegeProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return UpdateCollegeUsecase(repository: repository);
});
