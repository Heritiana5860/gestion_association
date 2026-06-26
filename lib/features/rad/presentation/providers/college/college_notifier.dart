import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/college_provider.dart';

class CollegeNotifier extends AsyncNotifier {
  @override
  FutureOr<dynamic> build() {}

  Future<void> newCollegeProvider({required CollegeModel model}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCollegeProvider);
    final result = await usecase.callAddCollege(model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final collegeProvider = AsyncNotifierProvider<CollegeNotifier, void>(
  CollegeNotifier.new,
);
