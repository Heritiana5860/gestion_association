import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/card/card_style.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/build_info.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/cadre/cadre_dialog.dart';

class CadreCard extends StatelessWidget {
  const CadreCard({super.key, required this.item});

  final CadreEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CadreDialog(item: item),
        );
      },
      child: CardStyle(
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

                  BuildInfo(label: item.contact, icon: Icons.phone),

                  BuildInfo(label: item.fonction, icon: Icons.verified),

                  BuildInfo(label: item.address, icon: Icons.place),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
