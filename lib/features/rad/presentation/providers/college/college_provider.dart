import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/college_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/repositories/college_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return CollegeDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.read(datasourceProvider);
  return CollegeRepositoryImpl(datasource: datasource);
});

final usecaseCollegeProvider = Provider((ref) {
  final repository = ref.read(repositoryProvider);
  return CollegeUsecase(repository: repository);
});
