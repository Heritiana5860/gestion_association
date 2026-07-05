import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/rad_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/ref_listen_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/add_obligation_notifier.dart';

class FormObligationDialog extends ConsumerStatefulWidget {
  const FormObligationDialog({super.key});

  @override
  ConsumerState<FormObligationDialog> createState() =>
      _FormObligationDialogState();
}

class _FormObligationDialogState extends ConsumerState<FormObligationDialog> {
  final formKey = GlobalKey<FormState>();

  late final ProviderSubscription<AsyncValue<void>> _obligationSubscription;

  final doyenInterne = TextEditingController();
  final doyenExterne = TextEditingController();
  final noviceInterne = TextEditingController();
  final noviceExterne = TextEditingController();
  final year = TextEditingController();

  void _submit() {
    if (formKey.currentState!.validate()) {
      final entity = ObligationEntity(
        noviceAmountIn: double.tryParse(noviceInterne.text) ?? 0.0,
        noviceAmountExt: double.tryParse(doyenExterne.text) ?? 0.0,
        doyenAncienIn: double.tryParse(doyenInterne.text) ?? 0.0,
        doyenAncienExt: double.tryParse(doyenExterne.text) ?? 0.0,
        year: int.tryParse(year.text) ?? DateTime.now().year,
      );

      ref.read(insertObligationProvider.notifier).newObligation(entity);
    }
  }

  @override
  void initState() {
    super.initState();

    _obligationSubscription = ref.listenManual<AsyncValue<void>>(
      insertObligationProvider,
      (previous, next) {
        if (previous is AsyncLoading && next is AsyncData) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: RadText.saveSucces,
                color: AppColor.white,
              ),
            ),
          );

          if (context.mounted) context.pop();
        }

        if (next is AsyncError) {
          RefListenError.errorListenProvider(
            context: context,
            error: next.error,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addOb = ref.watch(insertObligationProvider);
    final isLoading = addOb is AsyncLoading;

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
    _obligationSubscription.close();
    super.dispose();
  }
}
