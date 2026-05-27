import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';

class EventSubmitNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submitEvent({required EventModel model}) async {
    final usecase = ref.read(usecaseEventProvider);
    state = AsyncLoading();

    final result = await usecase.callSubmit(model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final newEventProvider = AsyncNotifierProvider<EventSubmitNotifier, void>(
  EventSubmitNotifier.new,
);
