import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/login/auth_login_provider.dart';

class AuthLoginNotifier extends AsyncNotifier<AuthSessionEntity?> {
  @override
  FutureOr<AuthSessionEntity?> build() {
    return null;
  }

  Future<void> signIn({required LoginParams entity}) async {
    state = const AsyncLoading();

    final usecase = ref.read(usecaseLoginProvider);

    final result = await usecase.call(entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final loginProvider =
    AsyncNotifierProvider<AuthLoginNotifier, AuthSessionEntity?>(
      AuthLoginNotifier.new,
    );
