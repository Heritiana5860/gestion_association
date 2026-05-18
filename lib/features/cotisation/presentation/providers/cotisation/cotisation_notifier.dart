import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_provider.dart';

class CotisationNotifier extends AsyncNotifier<List<CotisationEntity>> {
  @override
  FutureOr<List<CotisationEntity>> build() {
    final usecase = ref.watch(usecaseCotisationProvider);
    return usecase.call();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final cotisationDataProvider =
    AsyncNotifierProvider<CotisationNotifier, List<CotisationEntity>>(
      CotisationNotifier.new,
    );
