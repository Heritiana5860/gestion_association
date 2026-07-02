import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_circular.dart';

class BuildLoading extends StatelessWidget {
  const BuildLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: AppCircular(),
    );
  }
}
