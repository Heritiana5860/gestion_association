import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/rad_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/member_data_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_dropdown.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/college_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/get_college_notifier.dart';

class CollegeDialog extends ConsumerStatefulWidget {
  const CollegeDialog({super.key, this.item});

  final CollegeEntity? item;

  @override
  ConsumerState<CollegeDialog> createState() => _CollegeDialogState();
}

class _CollegeDialogState extends ConsumerState<CollegeDialog> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final contact = TextEditingController();
  final etablissement = TextEditingController();
  final nomPromotion = TextEditingController();
  final address = TextEditingController();
  final year = TextEditingController();

  String selectedLevel = "L1";

  void _createCollege() {
    final model = CollegeModel(
      nom: nom.text,
      contact: contact.text,
      address: address.text,
      etablissement: etablissement.text,
      niveau: selectedLevel,
      nomPromotion: nomPromotion.text,
      year: year.text,
    );

    if (formKey.currentState!.validate()) {
      ref.read(collegeProvider.notifier).newCollegeProvider(model: model);
    }
  }

  void _updateCollege() {
    if (!formKey.currentState!.validate()) return;

    final model = CollegeModel(
      nom: nom.text,
      contact: contact.text,
      address: address.text,
      etablissement: etablissement.text,
      niveau: selectedLevel,
      nomPromotion: nomPromotion.text,
      year: year.text,
    );

    ref
        .read(collegeProvider.notifier)
        .updateCollegeProvider(id: widget.item!.id!, model: model);
  }

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nom.text = widget.item!.nom;
      contact.text = widget.item!.contact;
      address.text = widget.item!.address;
      etablissement.text = widget.item!.etablissement;
      selectedLevel = widget.item!.niveau;
      nomPromotion.text = widget.item!.nomPromotion;
      year.text = widget.item!.year;
    }
  }

  bool get _isEditing => widget.item != null;

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    etablissement.dispose();
    nomPromotion.dispose();
    address.dispose();
    year.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(collegeProvider, (_, next) {
      next.whenOrNull(
        data: (data) {
          context.pop();

          ref.read(collegeDataProvider.notifier).refresh();
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.red,
              content: AppText(label: "$error", color: AppColor.white),
            ),
          );
        },
      );
    });

    final college = ref.watch(collegeProvider);
    final isLoading = college is AsyncLoading;

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
                DialogHeader(headerTitle: "Nouveau Collège des doyens"),
                AppInput(
                  controller: nom,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Nom complet",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: contact,
                  keyboardType: TextInputType.phone,
                  enabled: !isLoading,
                  labelText: "Contact",
                  maxLength: 10,
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: etablissement,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Etablissement",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
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
                AppInput(
                  controller: nomPromotion,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Nom de promotion",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: year,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  labelText: "Cette année",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: address,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Adresse",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                Divider(color: AppColor.white),

                SizedBox(
                  width: double.maxFinite,
                  child: AppButton(
                    label: isLoading
                        ? (_isEditing
                              ? RadText.modifEncours
                              : RadText.saveEnCours)
                        : (_isEditing ? RadText.modif : RadText.save),
                    onPressed: (_isEditing ? _updateCollege : _createCollege),
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
