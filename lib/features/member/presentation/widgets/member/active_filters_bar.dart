import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_filters_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/active_chip.dart';

class ActiveFiltersBar extends StatelessWidget {
  final MemberFiltersModel filters;
  final VoidCallback onClear;
  final ValueChanged<String> onRemove;

  const ActiveFiltersBar({
    super.key,
    required this.filters,
    required this.onClear,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (filters.search != null && filters.search!.isNotEmpty)
            ActiveChip(
              label: '${filters.search}',
              onRemove: () => onRemove('search'),
            ),
          if (filters.statut != null)
            ActiveChip(
              label: filters.statut!,
              onRemove: () => onRemove('statut'),
            ),
          if (filters.level != null)
            ActiveChip(
              label: filters.level!,
              onRemove: () => onRemove('level'),
            ),
          if (filters.isInside != null)
            ActiveChip(
              label: filters.isInside! ? 'Interne' : 'Externe',
              onRemove: () => onRemove('isInside'),
            ),
          TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.clear_all, size: 16),
            label: const Text("Tout effacer"),
            style: TextButton.styleFrom(foregroundColor: AppColor.red),
          ),
        ],
      ),
    );
  }
}
