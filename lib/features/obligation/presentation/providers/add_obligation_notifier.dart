import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_provider.dart';

class AddObligationNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> newObligation({required ObligationModel model}) async {
    final usecase = ref.read(usecaseAddObligationProvider);

    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await usecase.callAdd(model: model);
    });
  }
}

final insertObligationProvider =
    AsyncNotifierProvider<AddObligationNotifier, void>(
      AddObligationNotifier.new,
    );
