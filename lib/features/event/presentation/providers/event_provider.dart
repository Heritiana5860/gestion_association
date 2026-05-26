import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/dio_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/datasources/event_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/repositories/event_repository_impl.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/usecases/event_usecase.dart';

final datasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return EventDatasource(dio: dio);
});

final repositoryProvider = Provider((ref) {
  final datasource = ref.watch(datasourceProvider);
  return EventRepositoryImpl(datasource: datasource);
});

final usecaseEventProvider = Provider((ref) {
  final repository = ref.watch(repositoryProvider);
  return EventUsecase(repository: repository);
});
