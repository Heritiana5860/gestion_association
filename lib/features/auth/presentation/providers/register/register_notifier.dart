import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/info_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/register/register_provider.dart';

class RegisterNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createNewUser({required AuthRegisterModel model}) async {
    final usecase = ref.read(usecaseRegisterProvider);

    state = AsyncLoading();

    try {
      final result = await usecase.newUser(model: model);

      result.fold(
        (failure) {
          state = AsyncError(failure.message, StackTrace.current);
        },
        (info) {
          ref.read(infoProvider.notifier).state = info;
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, stack) {
      state = AsyncError(e.toString(), stack);
    }
  }
}

final newUserProvider = AsyncNotifierProvider<RegisterNotifier, void>(
  RegisterNotifier.new,
);
