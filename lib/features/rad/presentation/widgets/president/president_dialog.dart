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
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
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

  late final ProviderSubscription<AsyncValue<void>> _presidentSubscription;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      nom.text = widget.item!.nom;
      contact.text = widget.item!.contact ?? "";
      bio.text = widget.item!.bio;
      mandat.text = widget.item!.year;
    }

    _presidentSubscription = ref.listenManual<AsyncValue<void>>(
      presidenProvider,
      (previous, next) {
        if (previous is AsyncLoading && next is AsyncData) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: _isEditing ? RadText.modifSucces : RadText.saveSucces,
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

  void _createPresident() {
    if (!formKey.currentState!.validate()) return;

    final entity = PresidentEntity(
      nom: nom.text,
      contact: contact.text,
      year: mandat.text,
      bio: bio.text,
    );

    ref.read(presidenProvider.notifier).addPresident(entity);
  }

  void _updatePresident() {
    if (!formKey.currentState!.validate()) return;

    final entity = PresidentEntity(
      nom: nom.text,
      contact: contact.text,
      year: mandat.text,
      bio: bio.text,
    );

    ref
        .read(presidenProvider.notifier)
        .updatePresident(id: widget.item!.id!, entity: entity);
  }

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    bio.dispose();
    mandat.dispose();
    _presidentSubscription.close();
    super.dispose();
  }

  bool get _isEditing => widget.item != null;

  @override
  Widget build(BuildContext context) {
    final presidents = ref.watch(presidenProvider);
    final isLoading = presidents is AsyncLoading;

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
                  enabled: !isLoading,
                  labelText: "Nom complet",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: mandat,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  labelText: "Année de mandat",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),
                AppInput(
                  controller: bio,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Bio ou slogan",
                ),
                Divider(color: AppColor.white),

                // Footer
                SizedBox(
                  width: double.maxFinite,
                  child: AppButton(
                    label: isLoading
                        ? (_isEditing
                              ? RadText.modifEncours
                              : RadText.saveEnCours)
                        : (_isEditing ? RadText.modif : RadText.save),
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
