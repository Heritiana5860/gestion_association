import 'package:flutter_riverpod/legacy.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

final infoProvider = StateProvider<InfoEntity>(
  (ref) => InfoEntity(fullName: '', username: ''),
);
