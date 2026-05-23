import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_provider.dart';

class ObligationNotifier extends AsyncNotifier<List<ObligationEntity>> {
  @override
  FutureOr<List<ObligationEntity>> build() async {
    final usecase = ref.watch(usecaseAddObligationProvider);
    final result = await usecase.call();
    return result.fold((l) => throw ValidationError(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final obligationsProvider =
    AsyncNotifierProvider<ObligationNotifier, List<ObligationEntity>>(
      ObligationNotifier.new,
    );
