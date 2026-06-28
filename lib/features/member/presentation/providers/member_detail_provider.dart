import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';

final detailProvider = FutureProvider.family<MemberEntity, int>((
  ref,
  id,
) async {
  final selectedYear = ref.watch(selectedYearProvider) ?? "2026";
  final usecase = ref.watch(memberUsecaseProvider);

  final result = await usecase.callDetailMember(id: id, year: selectedYear);
  return result.fold((l) => throw Exception(l.message), (r) => r);
});
