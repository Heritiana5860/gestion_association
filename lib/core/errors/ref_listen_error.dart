import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class RefListenError {
  const RefListenError._();

  static void errorListenProvider({
    required Object error,
    required BuildContext context,
  }) {
    final message = error is Failure
        ? error.message
        : "Une erreur est survenue.";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.red,
        content: AppText(label: message, color: AppColor.white),
      ),
    );
  }
}
