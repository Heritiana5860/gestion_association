import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/cadre_provider.dart';

class FetchCadreNotifier extends AsyncNotifier<List<CadreEntity>> {
  @override
  FutureOr<List<CadreEntity>> build() async {
    final usecase = ref.watch(usecaseCadreProvider);
    final res = await usecase.callCadre();

    return res.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final fetchCadre = AsyncNotifierProvider<FetchCadreNotifier, List<CadreEntity>>(
  FetchCadreNotifier.new,
);
