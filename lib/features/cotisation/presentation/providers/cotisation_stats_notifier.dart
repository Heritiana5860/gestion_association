import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation_stats_provider.dart';

class CotisationStatsNotifier extends AsyncNotifier<CotisationStatsEntity> {
  @override
  FutureOr<CotisationStatsEntity> build() {
    final usecase = ref.watch(usecaseCotisationStatsProvider);

    return usecase.call();
  }
}

final cotisationStats =
    AsyncNotifierProvider<CotisationStatsNotifier, CotisationStatsEntity>(
      CotisationStatsNotifier.new,
    );
