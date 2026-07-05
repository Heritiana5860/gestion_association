import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/cadre_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/fetch_cadre_notifier.dart';

class CadreNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addNewCadre(CadreEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseAddCadreProvider);
    final result = await usecase.call(entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await ref.read(fetchCadre.notifier).refresh();
    });
  }

  Future<void> cadreUpdate({
    required int id,
    required CadreEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseUpdateCadreProvider);
    final result = await usecase.callCadreUpdate(id: id, entity: entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await ref.read(fetchCadre.notifier).refresh();
    });
  }
}

final cadreProvider = AsyncNotifierProvider<CadreNotifier, void>(
  CadreNotifier.new,
);
