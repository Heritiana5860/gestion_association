import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/honneur_provider.dart';

class HonneurNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createHonneur({required HonneurModel model}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseHonneurProvider);
    final result = await usecase.call(model: model);

    result.fold(
      (l) => throw Exception(l.message),
      (r) => state = AsyncData(null),
    );
  }

  Future<void> honneurUpdateProvider({
    required int id,
    required HonneurModel model,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseHonneurProvider);
    final result = await usecase.callUpdateHonneur(id: id, model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final honneurProvider = AsyncNotifierProvider<HonneurNotifier, void>(
  HonneurNotifier.new,
);
