import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

void messageRoleMember(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.orange,
      content: AppText(
        label: "Vous n'êtes pas authorisé pour cette opération.",
        color: AppColor.white,
      ),
    ),
  );
}
