import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';

final detailProvider = FutureProvider.family<MemberEntity, int>((ref, id) {
  final usecase = ref.watch(memberUsecaseProvider);
  return usecase.callDetailMember(id: id);
});
