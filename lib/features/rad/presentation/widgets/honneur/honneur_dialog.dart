import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/honneur_notifier.dart';

class HonneurDialog extends ConsumerStatefulWidget {
  const HonneurDialog({super.key});

  @override
  ConsumerState<HonneurDialog> createState() => _HonneurDialogState();
}

class _HonneurDialogState extends ConsumerState<HonneurDialog> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final contact = TextEditingController();
  final fonction = TextEditingController();
  final mandat = TextEditingController();
  final address = TextEditingController();

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    fonction.dispose();
    mandat.dispose();
    address.dispose();
    super.dispose();
  }

  void _createHonneur() {
    try {
      final model = HonneurModel(
        nom: nom.text,
        fonction: fonction.text,
        contact: contact.text,
        year: mandat.text,
        address: address.text,
      );

      if (formKey.currentState!.validate()) {
        ref.read(honneurProvider.notifier).createHonneur(model: model);
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
  Widget build(BuildContext context) {
    final honneurs = ref.watch(honneurProvider);
    final isLoading = honneurs is AsyncLoading;

    ref.listen<AsyncValue<void>>(honneurProvider, (_, next) {
      next.whenOrNull(
        data: (_) {
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: "Président d'honneur ajouté avec succès!",
                color: AppColor.white,
              ),
            ),
          );
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12.h,
              children: [
                DialogHeader(headerTitle: "Nouveau Président(e) d'honneur"),
                AppInput(
                  controller: nom,
                  keyboardType: TextInputType.text,
                  labelText: "Nom complet",
                ),
                AppInput(
                  controller: fonction,
                  keyboardType: TextInputType.text,
                  labelText: "Fonction",
                ),
                AppInput(
                  controller: contact,
                  keyboardType: TextInputType.phone,
                  labelText: "Contact",
                  maxLength: 10,
                ),
                AppInput(
                  controller: mandat,
                  keyboardType: TextInputType.number,
                  labelText: "Année de mandat",
                ),
                AppInput(
                  controller: address,
                  keyboardType: TextInputType.text,
                  labelText: "Adresse",
                ),
                Divider(color: AppColor.white),

                SizedBox(
                  width: double.maxFinite,
                  child: AppButton(
                    label: isLoading ? "Ajouter en cours..." : "Enregistrer",
                    onPressed: _createHonneur,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
