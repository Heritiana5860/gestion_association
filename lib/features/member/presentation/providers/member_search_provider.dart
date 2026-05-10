import 'package:flutter_riverpod/legacy.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_filters_model.dart';

final memberSearchProvider = StateProvider<String>((ref) => "");

final memberFilterProvider = StateProvider<MemberFiltersModel>(
  (ref) => MemberFiltersModel(),
);
