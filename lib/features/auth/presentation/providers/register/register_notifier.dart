import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_register_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/register/register_provider.dart';

class RegisterNotifier extends AsyncNotifier<AuthSessionEntity?> {
  @override
  FutureOr<AuthSessionEntity?> build() {
    return null;
  }

  Future<void> createNewUser({required AuthRegisterEntity entity}) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseRegisterProvider);

    final result = await usecase.call(entity);

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (info) => state = AsyncValue.data(info),
    );
  }
}

final newUserProvider =
    AsyncNotifierProvider<RegisterNotifier, AuthSessionEntity?>(
      RegisterNotifier.new,
    );
