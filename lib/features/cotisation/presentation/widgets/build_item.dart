import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildItem extends StatelessWidget {
  const BuildItem({
    super.key,
    required this.label,
    required this.value,
    this.color = AppColor.black,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(label: label),
        AppText(label: value, color: color, fontWeight: FontWeight.bold),
      ],
    );
  }
}
