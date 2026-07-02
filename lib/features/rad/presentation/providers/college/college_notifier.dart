import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/college_provider.dart';

class CollegeNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> newCollegeProvider(CollegeEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCollegeProvider);

    final result = await usecase.callAddCollege(entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }

  Future<void> updateCollegeProvider({
    required int id,
    required CollegeEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCollegeProvider);

    final result = await usecase.callCollegeUpdate(id: id, entity: entity);
    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final collegeProvider = AsyncNotifierProvider<CollegeNotifier, void>(
  CollegeNotifier.new,
);
