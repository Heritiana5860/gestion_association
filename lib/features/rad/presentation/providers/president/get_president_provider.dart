import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/president_provider.dart';

class GetPresidentProvider extends AsyncNotifier<List<PresidentEntity>> {
  @override
  FutureOr<List<PresidentEntity>> build() async {
    final usecase = ref.watch(usecasePresidentProvider);
    final result = await usecase.fetchPresidentList();

    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final getPresidentProvider =
    AsyncNotifierProvider<GetPresidentProvider, List<PresidentEntity>>(
      GetPresidentProvider.new,
    );
