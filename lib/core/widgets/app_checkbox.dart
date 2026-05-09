import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    this.value,
    this.onChanged,
    required this.title,
  });

  final bool? value;
  final void Function(bool?)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: AppColor.blue,
      title: AppText(label: title),
    );
  }
}
