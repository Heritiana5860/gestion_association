import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_height.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeHeight.twentyFourHeight,
      width: double.maxFinite,
      child: SvgPicture.asset("assets/logo/logo.svg", fit: BoxFit.cover),
    );
  }
}
