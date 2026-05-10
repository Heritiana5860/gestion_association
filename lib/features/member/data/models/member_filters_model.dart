import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_filters_entity.dart';

class MemberFiltersModel extends MemberFiltersEntity {
  const MemberFiltersModel({
    super.search,
    super.statut,
    super.level,
    super.isInside,
  });

  MemberFiltersModel copyWith({
    Object? search = _sentinel,
    Object? statut = _sentinel,
    Object? level = _sentinel,
    Object? isInside = _sentinel,
  }) {
    String? resolveString(Object? val, String? current) {
      if (val == _sentinel) return current;
      final s = val as String?;
      return (s == null || s == "TOUS") ? null : s;
    }

    return MemberFiltersModel(
      search: search == _sentinel ? this.search : (search as String?),
      statut: resolveString(statut, this.statut),
      level: resolveString(level, this.level),
      isInside: isInside == _sentinel ? this.isInside : (isInside as bool?),
    );
  }

  bool get isEmpty =>
      search == null && statut == null && level == null && isInside == null;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (search != null && search!.isNotEmpty) map['search'] = search;
    if (statut != null) map['statut'] = statut;
    if (level != null) map['level'] = level;
    if (isInside != null) map['is_inside'] = isInside;
    return map;
  }
}

// Sentinelle pour distinguer "non passé" de "null explicite"
const Object _sentinel = Object();
