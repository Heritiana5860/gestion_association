import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_provider.dart';

class CotisationNotifier extends AsyncNotifier<List<CotisationEntity>> {
  Timer? _debounce;
  String _currentSearch = '';

  @override
  FutureOr<List<CotisationEntity>> build() async {
    return await _fetch(search: _currentSearch);
  }

  Future<List<CotisationEntity>> _fetch({String? search}) async {
    final usecase = ref.read(usecaseCotisationProvider);
    final result = await usecase.call(search: search);
    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _currentSearch = query;
      state = const AsyncLoading();
      state = await AsyncValue.guard(() => _fetch(search: query));
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final cotisationDataProvider =
    AsyncNotifierProvider<CotisationNotifier, List<CotisationEntity>>(
      CotisationNotifier.new,
    );
