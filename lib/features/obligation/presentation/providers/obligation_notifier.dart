import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_provider.dart';

class ObligationNotifier extends AsyncNotifier<List<ObligationEntity>> {
  @override
  FutureOr<List<ObligationEntity>> build() {
    final usecase = ref.watch(usecaseAddObligationProvider);
    return usecase.call();
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
