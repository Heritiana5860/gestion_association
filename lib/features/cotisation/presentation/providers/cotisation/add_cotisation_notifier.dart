import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_provider.dart';

class AddCotisationNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> newCotisation({required AddCotisationEntity entity}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseCotisationProvider);

    final result = await usecase.addCotisationCall(entity: entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final payCotisation = AsyncNotifierProvider<AddCotisationNotifier, void>(
  AddCotisationNotifier.new,
);
