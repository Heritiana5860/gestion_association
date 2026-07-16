import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/material_provider.dart';

class ListMaterialProvider extends AsyncNotifier<List<MaterialEntity>> {
  @override
  FutureOr<List<MaterialEntity>> build() async {
    final usecase = ref.watch(listUsecaseMaterialProvider);
    final result = await usecase.call();

    return result.fold((l) => throw l, (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final listMaterialProvider =
    AsyncNotifierProvider<ListMaterialProvider, List<MaterialEntity>>(
      ListMaterialProvider.new,
    );
