import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/card/card_style.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/build_info.dart';

class HonneurCard extends StatelessWidget {
  const HonneurCard({super.key, required this.item});

  final HonneurEntity item;

  @override
  Widget build(BuildContext context) {
    return CardStyle(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // L'avatar à gauche
          CircleAvatar(
            radius: 26.r,
            backgroundColor: AppColor.blue.withValues(alpha: 0.1),
            child: AppText(
              label: item.nom.isNotEmpty ? item.nom[0].toUpperCase() : "?",
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(width: 14.w),

          // Les informations alignées à droite de l'avatar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                AppText(
                  label: item.nom,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                ),

                // Ligne d'infos secondaires côte à côte pour gagner de la place verticalement
                Row(
                  children: [
                    Expanded(
                      child: BuildInfo(
                        label: item.year,
                        icon: Icons.date_range,
                      ),
                    ),
                    Expanded(
                      child: BuildInfo(label: item.contact, icon: Icons.phone),
                    ),
                  ],
                ),

                BuildInfo(label: item.fonction, icon: Icons.verified),

                BuildInfo(label: item.address, icon: Icons.place),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
