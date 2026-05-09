import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/member_data_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_checkbox.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_dropdown.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_add_notifier.dart';

class AddMemberDialog extends ConsumerStatefulWidget {
  const AddMemberDialog({super.key});

  @override
  ConsumerState<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends ConsumerState<AddMemberDialog> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final cdeController = TextEditingController();
  final adresseController = TextEditingController();
  final etablissementController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedLevel = "L1";
  String selectedStatut = "Novice";
  bool? isInside = false;

  @override
  Widget build(BuildContext context) {
    final newMember = ref.watch(newMemberProvider);
    final isLoading = newMember is AsyncLoading;

    ref.listen<AsyncValue<void>>(newMemberProvider, (previous, next) {
      next.whenOrNull(
        data: (_) => context.pop(),
        error: (error, _) {
          debugPrint("Erreur: $error");
        },
      );
    });

    return Dialog(
      backgroundColor: AppColor.scaffoldBackground,
      insetPadding: EdgeInsets.all(12.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColor.white)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppText(
                          label: "Nouveau membre",
                          color: AppColor.blue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(Icons.close, color: AppColor.red),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                // Body
                AppInput(
                  labelText: "Nom complet",
                  controller: fullNameController,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                AppInput(
                  labelText: "Numero téléphone",
                  controller: numberPhoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                AppInput(
                  labelText: "N° carte d'étudiant",
                  controller: cdeController,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                AppInput(
                  labelText: "Adresse",
                  controller: adresseController,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                AppInput(
                  labelText: "Etablissement",
                  controller: etablissementController,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                AppDropdown(
                  labelText: "Niveau",
                  value: selectedLevel,
                  items: levelData
                      .map(
                        (level) => DropdownMenuItem<String>(
                          value: level,
                          child: AppText(label: level),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value!;
                    });
                  },
                ),
                SizedBox(height: 6.h),
                AppDropdown(
                  labelText: "Statut",
                  value: selectedStatut,
                  items: statutData
                      .map(
                        (statut) => DropdownMenuItem<String>(
                          value: statut,
                          child: AppText(label: statut),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatut = value!;
                    });
                  },
                ),
                SizedBox(height: 6.h),
                AppCheckbox(
                  title: "Résidez-vous sur le campus universitaire ?",
                  value: isInside,
                  onChanged: (value) {
                    setState(() {
                      isInside = value;
                    });
                  },
                ),

                SizedBox(height: 6.h),

                Divider(color: AppColor.white),

                SizedBox(height: 6.h),

                // Footer
                SizedBox(
                  width: double.maxFinite,
                  child: AppButton(
                    label: isLoading ? "Ajout en cours..." : "Ajouter",
                    onPressed: isLoading
                        ? null
                        : () {
                            final model = MemberModel(
                              fullName: fullNameController.text.trim(),
                              numberPhone: numberPhoneController.text.trim(),
                              isInside: (isInside as bool),
                              cde: cdeController.text.trim(),
                              address: adresseController.text.trim(),
                              school: etablissementController.text.trim(),
                              level: selectedLevel,
                              statut: selectedStatut.toUpperCase(),
                            );
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(newMemberProvider.notifier)
                                  .addMember(model: model);
                            }
                          },
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
