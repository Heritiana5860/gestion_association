import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president_notifier.dart';

class PresidentPage extends ConsumerStatefulWidget {
  const PresidentPage({super.key});

  @override
  ConsumerState<PresidentPage> createState() => _PresidentPageState();
}

class _PresidentPageState extends ConsumerState<PresidentPage> {
  void _openPresidentDialog() {
    showDialog(context: context, builder: (context) => PresidentDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: AppText(label: "Président(s)"), centerTitle: true),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "president-btn",
        icon: Icons.person_pin_rounded,
        onPressed: _openPresidentDialog,
      ),
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
                    child: Center(child: AppText(label: "President")),
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

class PresidentDialog extends ConsumerStatefulWidget {
  const PresidentDialog({super.key});

  @override
  ConsumerState<PresidentDialog> createState() => _PresidentDialogState();
}

class _PresidentDialogState extends ConsumerState<PresidentDialog> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final contact = TextEditingController();
  final bio = TextEditingController();
  final mandat = TextEditingController();

  void _createPresident() {
    try {
      final model = PresidentModel(
        nom: nom.text,
        contact: contact.text,
        year: mandat.text,
        bio: bio.text,
      );

      if (formKey.currentState!.validate()) {
        ref.read(presidenProvider.notifier).addPresident(model: model);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.red,
          content: AppText(label: "Erreur: $e", color: AppColor.white),
        ),
      );
    }
  }

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    bio.dispose();
    mandat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presidents = ref.watch(presidenProvider);
    final isLoading = presidents is AsyncLoading;

    ref.listen(presidenProvider, (_, next) {
      next.whenOrNull(
        data: (_) {
          Navigator.pop(context);
        },
      );
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      backgroundColor: AppColor.scaffoldBackground,
      insetPadding: EdgeInsets.all(12.r),
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.h,
            children: [
              DialogHeader(headerTitle: "Nouveau Président(e)"),
              AppInput(
                controller: nom,
                keyboardType: TextInputType.text,
                labelText: "Nom complet",
              ),
              AppInput(
                controller: contact,
                keyboardType: TextInputType.phone,
                labelText: "Contact",
              ),
              AppInput(
                controller: mandat,
                keyboardType: TextInputType.number,
                labelText: "Anné de mandat",
              ),
              AppInput(
                controller: bio,
                keyboardType: TextInputType.text,
                labelText: "Bio ou slogan",
              ),
              Divider(color: AppColor.white),

              // Footer
              SizedBox(
                width: double.maxFinite,
                child: AppButton(
                  label: isLoading ? "Ajouter en cours..." : "Enregistrer",
                  onPressed: _createPresident,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
