import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';

final deleteMemberProvider = FutureProvider.family<void, int>((ref, id) async {
  final usecase = ref.read(memberUsecaseProvider);
  await usecase.callDeleteMember(id: id);
});
