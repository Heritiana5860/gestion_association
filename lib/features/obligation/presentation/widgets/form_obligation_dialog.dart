import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_notifier.dart';

class FormObligationDialog extends ConsumerStatefulWidget {
  const FormObligationDialog({super.key});

  @override
  ConsumerState<FormObligationDialog> createState() =>
      _FormObligationDialogState();
}

class _FormObligationDialogState extends ConsumerState<FormObligationDialog> {
  final formKey = GlobalKey<FormState>();

  final doyenInterne = TextEditingController();
  final doyenExterne = TextEditingController();
  final noviceInterne = TextEditingController();
  final noviceExterne = TextEditingController();
  final year = TextEditingController();

  void _submit() {
    if (formKey.currentState!.validate()) {
      final model = ObligationModel(
        noviceAmountIn: double.tryParse(noviceInterne.text) ?? 0.0,
        noviceAmountExt: double.tryParse(doyenExterne.text) ?? 0.0,
        doyenAncienIn: double.tryParse(doyenInterne.text) ?? 0.0,
        doyenAncienExt: double.tryParse(doyenExterne.text) ?? 0.0,
        year: int.tryParse(year.text) ?? DateTime.now().year,
      );

      ref.read(insertObligationProvider.notifier).newObligation(model: model);
    }
  }

  void _clear() {
    doyenInterne.clear();
    doyenExterne.clear();
    noviceExterne.clear();
    noviceInterne.clear();
    year.clear();
  }

  @override
  Widget build(BuildContext context) {
    final addOb = ref.watch(insertObligationProvider);
    final isLoading = addOb is AsyncLoading;

    ref.listen<AsyncValue<void>>(insertObligationProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          _clear();
          context.pop();
        },
        error: (error, _) => ScaffoldMessenger(
          child: SnackBar(
            content: AppText(label: "Erreur: $error", color: AppColor.red),
          ),
        ),
      );
    });

    return Dialog(
      backgroundColor: AppColor.scaffoldBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              spacing: 8.h,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        label: "Obligation",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.close, color: AppColor.red),
                    ),
                  ],
                ),
                Divider(color: AppColor.lightGrey),
                SizedBox(height: 3.h),
                AppInput(
                  controller: year,
                  labelText: "Année (ex: 2026)",
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: doyenInterne,
                  labelText: "Doyens et Anciens interne",
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: doyenExterne,
                  labelText: "Doyens et Anciens Externe",
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: noviceInterne,
                  labelText: "Novice interne",
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: noviceExterne,
                  labelText: "Novice externe",
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 3.h),
                AppButton(
                  label: isLoading ? "En cours..." : "Sauvegarder",
                  onPressed: isLoading ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    doyenExterne.dispose();
    doyenInterne.dispose();
    noviceExterne.dispose();
    noviceInterne.dispose();
    year.dispose();
    super.dispose();
  }
}
