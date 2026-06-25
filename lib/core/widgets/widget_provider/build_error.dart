import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildError extends StatelessWidget {
  const BuildError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: AppText(label: "$error", color: AppColor.red),
      ),
    );
  }
}
