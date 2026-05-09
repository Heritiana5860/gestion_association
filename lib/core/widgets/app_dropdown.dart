import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    this.items,
    this.onChanged,
    required this.labelText,
  });

  final String value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
        ),
        filled: true,
        fillColor: AppColor.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      initialValue: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
