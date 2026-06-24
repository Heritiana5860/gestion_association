import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/honneur_provider.dart';

class GetHonneurProvider extends AsyncNotifier<List<HonneurEntity>> {
  @override
  FutureOr<List<HonneurEntity>> build() async {
    final usecase = ref.watch(usecaseHonneurProvider);
    final result = await usecase.callFetchHonneur();

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final getHonneurs =
    AsyncNotifierProvider<GetHonneurProvider, List<HonneurEntity>>(
      GetHonneurProvider.new,
    );
