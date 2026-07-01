import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_provider.dart';

class CotisationStatsNotifier extends AsyncNotifier<CotisationStatsEntity> {
  @override
  FutureOr<CotisationStatsEntity> build() async {
    final selectedYear = ref.watch(selectedYearProvider) ?? "2026";
    final usecase = ref.watch(usecaseCotisationStatsProvider);

    final result = await usecase.call(year: selectedYear);

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final cotisationStats =
    AsyncNotifierProvider<CotisationStatsNotifier, CotisationStatsEntity>(
      CotisationStatsNotifier.new,
    );
