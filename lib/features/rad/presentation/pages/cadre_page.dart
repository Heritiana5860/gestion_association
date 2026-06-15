import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class CadrePage extends StatefulWidget {
  const CadrePage({super.key});

  @override
  State<CadrePage> createState() => _CadrePageState();
}

class _CadrePageState extends State<CadrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: Text("Cadre")),
      body: Center(child: Text("Cadre Page")),
    );
  }
}
