import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/get_president_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/president_notifier.dart';

class PresidentDialog extends ConsumerStatefulWidget {
  const PresidentDialog({super.key, this.item});

  final PresidentEntity? item;

  @override
  ConsumerState<PresidentDialog> createState() => _PresidentDialogState();
}

class _PresidentDialogState extends ConsumerState<PresidentDialog> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final contact = TextEditingController();
  final bio = TextEditingController();
  final mandat = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      nom.text = widget.item!.nom;
      contact.text = widget.item!.contact;
      bio.text = widget.item!.bio;
      mandat.text = widget.item!.year;
    }
  }

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

  void _updatePresident() {
    if (!formKey.currentState!.validate()) return;

    final model = PresidentModel(
      nom: nom.text,
      contact: contact.text,
      year: mandat.text,
      bio: bio.text,
    );

    ref
        .read(presidenProvider.notifier)
        .updatePresident(id: widget.item!.id!, model: model);
  }

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    bio.dispose();
    mandat.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.item != null;

  @override
  Widget build(BuildContext context) {
    final presidents = ref.watch(presidenProvider);
    final isLoading = presidents is AsyncLoading;

    ref.listen<AsyncValue<void>>(presidenProvider, (_, next) {
      next.whenOrNull(
        data: (_) {
          context.pop();

          ref.read(getPresidentProvider.notifier).refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: _isEditing
                    ? "Modification avec succès !"
                    : "Président ajouté avec succès !",
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
                DialogHeader(headerTitle: "Nouveau Président(e)"),
                AppInput(
                  controller: nom,
                  keyboardType: TextInputType.text,
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
                  controller: mandat,
                  keyboardType: TextInputType.number,
                  labelText: "Année de mandat",
                  validator: (p0) {
                    if (p0 == null) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
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
                    label: isLoading
                        ? (_isEditing
                              ? "Modification en cours..."
                              : "Ajouter en cours...")
                        : (_isEditing ? "Modifier" : "Enregistrer"),
                    onPressed: isLoading
                        ? null
                        : (_isEditing ? _updatePresident : _createPresident),
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
