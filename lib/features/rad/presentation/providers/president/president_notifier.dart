import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/president_provider.dart';

class PresidentNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<dynamic> build() {}

  Future<void> addPresident({required PresidentModel model}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecasePresidentProvider);
    final result = await usecase.call(model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final presidenProvider = AsyncNotifierProvider<PresidentNotifier, void>(
  PresidentNotifier.new,
);
