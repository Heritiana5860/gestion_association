import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icone visuel pour meubler l'espace de manière élégante
        Icon(
          icon,
          size: 64.r,
          color: AppColor.textDescription.withValues(alpha: 0.5),
        ),
        SizedBox(height: 16.h),

        // Titre principal
        AppText(
          label: label,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),

        // Sous-titre d'explication ou d'action
        AppText(
          label:
              "Il n'y a aucune donnée disponible pour le moment. Utilisez le bouton en bas pour en ajouter un.",
          color: AppColor.textDescription,
          fontSize: 13.sp,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
