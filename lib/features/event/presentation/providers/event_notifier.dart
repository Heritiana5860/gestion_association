import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';

class EventNotifier extends AsyncNotifier<List<EventEntity>> {
  @override
  FutureOr<List<EventEntity>> build() async {
    final selectedYear = ref.watch(selectedYearProvider) ?? "2026";
    final usecase = ref.watch(usecaseEventProvider);

    final result = await usecase.call(year: selectedYear);

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final eventProvider = AsyncNotifierProvider<EventNotifier, List<EventEntity>>(
  EventNotifier.new,
);
