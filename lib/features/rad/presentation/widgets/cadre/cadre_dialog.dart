import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/cadre_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/fetch_cadre_notifier.dart';

class CadreDialog extends ConsumerStatefulWidget {
  const CadreDialog({super.key, this.item});

  final CadreEntity? item;

  @override
  ConsumerState<CadreDialog> createState() => _CadreDialogState();
}

class _CadreDialogState extends ConsumerState<CadreDialog> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final fonction = TextEditingController();
  final contact = TextEditingController();
  final address = TextEditingController();

  @override
  void initState() {
    super.initState();
    final i = widget.item;
    if (i != null) {
      nom.text = i.nom;
      fonction.text = i.fonction;
      contact.text = i.contact;
      address.text = i.address;
    }
  }

  bool get _isEditing => widget.item != null;

  void _createCadre() {
    try {
      final model = CadreModel(
        nom: nom.text,
        fonction: fonction.text,
        contact: contact.text,
        address: address.text,
      );

      if (formKey.currentState!.validate()) {
        ref.read(cadreProvider.notifier).addNewCadre(model: model);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.red,
          content: AppText(label: "$e", color: AppColor.white),
        ),
      );
    }
  }

  void _updateCadre() {
    if (!formKey.currentState!.validate()) return;

    final model = CadreModel(
      nom: nom.text,
      fonction: fonction.text,
      contact: contact.text,
      address: address.text,
    );

    ref
        .read(cadreProvider.notifier)
        .cadreUpdate(id: widget.item!.id ?? 0, model: model);
  }

  @override
  void dispose() {
    nom.dispose();
    fonction.dispose();
    contact.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cadre = ref.watch(cadreProvider);
    final isLoading = cadre is AsyncLoading;

    ref.listen<AsyncValue<void>>(cadreProvider, (_, next) {
      next.whenOrNull(
        data: (data) {
          context.pop();

          ref.read(fetchCadre.notifier).refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: "Jeune cadre ajouté avec succès.",
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
                DialogHeader(headerTitle: "Nouveau jeune cadre"),

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
                  controller: address,
                  keyboardType: TextInputType.text,
                  labelText: "Adresse",
                ),
                Divider(color: AppColor.white),

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
                        : (_isEditing ? _updateCadre : _createCadre),
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
