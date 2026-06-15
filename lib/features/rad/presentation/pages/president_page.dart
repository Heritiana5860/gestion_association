import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';

class PresidentPage extends StatefulWidget {
  const PresidentPage({super.key});

  @override
  State<PresidentPage> createState() => _PresidentPageState();
}

class _PresidentPageState extends State<PresidentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: AppText(label: "Président(s)"), centerTitle: true),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    label: "Les président(s) de l'association",
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                  AppText(
                    label:
                        "Le président est le représentant légal de l'association. Il est élu par les membres de l'association.",
                    color: AppColor.textDescription,
                  ),
                ],
              ),
            ),

            SliverAnimatedGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: AppText(label: "Président ${index + 1}"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
