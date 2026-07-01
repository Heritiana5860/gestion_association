import 'package:flutter_riverpod/legacy.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';

final infoProvider = StateProvider<AuthSessionEntity>(
  (ref) =>
      AuthSessionEntity(access: '', refresh: '', firstName: '', username: ''),
);
