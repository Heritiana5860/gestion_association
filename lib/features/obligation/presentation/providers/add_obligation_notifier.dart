import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/obligation_notifier.dart';

class AddObligationNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> newObligation(ObligationEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseAddObligationProvider);

    final result = await usecase.callAdd(entity);
    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await ref.read(obligationsProvider.notifier).refresh();
    });
  }
}

final insertObligationProvider =
    AsyncNotifierProvider<AddObligationNotifier, void>(
      AddObligationNotifier.new,
    );
