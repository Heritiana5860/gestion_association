import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/rad/header_card_rad.dart';

class CollegePage extends StatefulWidget {
  const CollegePage({super.key});

  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: AppText(label: "Collège des doyens"),
        centerTitle: true,
      ),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "college-btn",
        icon: Icons.person_pin_rounded,
        onPressed: () {},
      ),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            HeaderCardRAD(
              title: "Les collèges des doyens de l'association",
              description:
                  "Le collège des doyens regroupe les anciens membres expérimentés de l'association. Ils apportent sagesse, conseils et accompagnement, afin de guider les plus jeunes et préserver la continuité des valeurs associatives.",
            ),
          ],
        ),
      ),
    );
  }
}
