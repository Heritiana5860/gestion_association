import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/list_material_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/material_provider.dart';

class PostMaterialNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addMaterialProvider(MaterialEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseMaterialProvider);
    final result = await usecase.callAdd(entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) {
      ref.read(listMaterialProvider.notifier).refresh();
      state = AsyncData(r);
    });
  }

  Future<void> updateMaterialProvider({
    required int id,
    required MaterialEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(updateUsecaseMaterialProvider);
    final result = await usecase.callUpdate(id: id, entity: entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) {
        ref.read(listMaterialProvider.notifier).refresh();
        state = AsyncData(r);
      }
    );
  }
}

final materialProvider = AsyncNotifierProvider<PostMaterialNotifier, void>(
  PostMaterialNotifier.new,
);
