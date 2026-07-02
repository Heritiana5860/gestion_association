import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class AppCircular extends StatelessWidget {
  const AppCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColor.blue));
  }
}
