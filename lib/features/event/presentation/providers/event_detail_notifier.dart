import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';

class EventDetailNotifier extends AsyncNotifier<EventEntity> {
  late final int id;

  @override
  FutureOr<EventEntity> build() async {
    final usecase = ref.watch(usecaseEventProvider);

    final result = await usecase.callDetail(id: id);

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }
}

final eventDetailProvider =
    AsyncNotifierProvider.family<EventDetailNotifier, EventEntity, int>((id) {
      final notifier = EventDetailNotifier();
      notifier.id = id;
      return notifier;
    });
