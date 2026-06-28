import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/list_entite.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/entite/entite_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/header_card.dart';

class ListSousEntite extends StatelessWidget {
  const ListSousEntite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderCard(
            total: listEntite.length,
            totalLabel: "entités",
            label: "Sous-entités de l'association",
            icon: Icons.groups,
          ),
          SizedBox(height: 12.h),
          ...List.generate(listEntite.length, (i) {
            final e = listEntite[i];
            final initials = (e['abbr'] as String).substring(0, 2);
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < listEntite.length - 1 ? 8.h : 0,
              ),
              child: EntiteCard(
                abbr: e['abbr'] as String,
                initials: initials,
                color: e['color'] as Color,
                bg: e['bg'] as Color,
                name: e['name'],
              ),
            );
          }),
        ],
      ),
    );
  }
}
