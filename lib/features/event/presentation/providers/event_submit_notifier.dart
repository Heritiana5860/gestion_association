import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';

class EventSubmitNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submitEvent({required EventEntity entity}) async {
    state = AsyncLoading();
    final usecase = ref.read(usecaseEventProvider);

    final result = await usecase.callSubmit(entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final newEventProvider = AsyncNotifierProvider<EventSubmitNotifier, void>(
  EventSubmitNotifier.new,
);
