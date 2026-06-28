import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/college_provider.dart';

class GetCollegeNotifier extends AsyncNotifier<List<CollegeEntity>> {
  @override
  FutureOr<List<CollegeEntity>> build() async {
    final selectedYear = ref.watch(selectedYearProvider) ?? "2026";
    final usecase = ref.watch(usecaseCollegeProvider);
    final result = await usecase.call(year: selectedYear);

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final collegeDataProvider =
    AsyncNotifierProvider<GetCollegeNotifier, List<CollegeEntity>>(
      GetCollegeNotifier.new,
    );
