import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/info_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/login/auth_login_provider.dart';

class AuthLoginNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required AuthModel model}) async {
    final usecase = ref.read(usecaseLoginProvider);

    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final info = await usecase.call(model: model);
      ref.read(infoProvider.notifier).state = InfoEntity(
        fullName: info.fullName,
        username: info.username,
      );
    });
  }
}

final login = AsyncNotifierProvider<AuthLoginNotifier, void>(
  AuthLoginNotifier.new,
);
