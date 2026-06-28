import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/list_tragno.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/header_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/tragno/section_bloc.dart';

class CampusCard extends StatelessWidget {
  const CampusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final total = batiments.length + prefabrique.length;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          HeaderCard(
            total: total,
            totalLabel: "salles",
            label: "Blocs campus",
            icon: Icons.apartment_rounded,
          ),

          SizedBox(height: 14.h),

          // Bâtiments
          SectionBloc(
            title: "Bâtiments",
            items: batiments,
            chipColor: const Color(0xFF185FA5),
            chipBg: const Color(0xFFE6F1FB),
            chipBorder: const Color(0xFFB5D4F4),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(height: 1, color: AppColor.lightGrey),
          ),

          // Préfabriqués
          SectionBloc(
            title: "Préfabriqués",
            items: prefabrique,
            chipColor: const Color(0xFF0F6E56),
            chipBg: const Color(0xFFE1F5EE),
            chipBorder: const Color(0xFF9FE1CB),
          ),
        ],
      ),
    );
  }
}
