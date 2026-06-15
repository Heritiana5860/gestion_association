import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class HonneurPage extends StatefulWidget {
  const HonneurPage({super.key});

  @override
  State<HonneurPage> createState() => _HonneurPageState();
}

class _HonneurPageState extends State<HonneurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: Text("Honneur")),
      body: Center(child: Text("Honneur Page")),
    );
  }
}
