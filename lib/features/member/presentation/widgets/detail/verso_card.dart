import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/card_base.dart';

class VersoCard extends StatelessWidget {
  const VersoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardBase(
      boxShadow: [
        BoxShadow(
          color: AppColor.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset("assets/logo/back.png", fit: BoxFit.cover),
      ),
    );
  }
}
