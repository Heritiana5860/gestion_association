import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/cadre_provider.dart';

class CadreNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addNewCadre({required CadreModel model}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCadreProvider);
    final result = await usecase.call(model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final cadreProvider = AsyncNotifierProvider<CadreNotifier, void>(
  CadreNotifier.new,
);
