import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/flutter_secure_storage_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/info_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/login/auth_login_provider.dart';

class AuthLoginNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required AuthModel model}) async {
    final usecase = ref.read(usecaseLoginProvider);
    final stoarge = ref.read(secureStorageProvider);

    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await usecase.call(model: model);
    });

    final info = await Future.wait([
      stoarge.read(key: InfoKey.fullName),
      stoarge.read(key: InfoKey.username),
    ]);

    ref.read(infoProvider.notifier).state = InfoEntity(
      fullName: info[0] ?? "",
      username: info[1] ?? "",
    );
  }
}

final login = AsyncNotifierProvider<AuthLoginNotifier, void>(
  AuthLoginNotifier.new,
);
