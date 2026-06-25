import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_provider.dart';

class AddCotisationNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> newCotisation({required AddCotisationModel model}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCotisationProvider);

    final result = await usecase.addCotisationCall(model: model);

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(null),
    );
  }
}

final payCotisation = AsyncNotifierProvider<AddCotisationNotifier, void>(
  AddCotisationNotifier.new,
);
