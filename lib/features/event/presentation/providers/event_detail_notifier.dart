import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';

final eventDetailProvider = FutureProvider.family<EventEntity, int>((
  ref,
  id,
) async {
  final usecase = ref.watch(usecaseEventProvider);
  final result = await usecase.callDetail(id: id);

  return result.fold((l) => throw Exception(l.message), (r) => r);
});
