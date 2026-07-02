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

  late final ProviderSubscription<AsyncValue<void>> _cadreSubscription;

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

    _cadreSubscription = ref.listenManual<AsyncValue<void>>(cadreProvider, (
      _,
      next,
    ) {
      next.whenOrNull(
        data: (_) async {
          if (!context.mounted) return;
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: _isEditing
                    ? RadText.modifSucces
                    : "Jeune cadre ajouté avec succès.",
                color: AppColor.white,
              ),
            ),
          );

          await ref.read(fetchCadre.notifier).refresh();
        },
        error: (error, _) =>
            RefListenError.errorListenProvider(context: context, error: error),
      );
    });
  }

  bool get _isEditing => widget.item != null;

  void _createCadre() {
    if (!formKey.currentState!.validate()) return;

    final entity = CadreEntity(
      nom: nom.text,
      fonction: fonction.text,
      contact: contact.text,
      address: address.text,
    );

    ref.read(cadreProvider.notifier).addNewCadre(entity);
  }

  void _updateCadre() {
    if (!formKey.currentState!.validate()) return;

    final entity = CadreEntity(
      nom: nom.text,
      fonction: fonction.text,
      contact: contact.text,
      address: address.text,
    );

    ref
        .read(cadreProvider.notifier)
        .cadreUpdate(id: widget.item!.id ?? 0, entity: entity);
  }

  @override
  void dispose() {
    nom.dispose();
    fonction.dispose();
    contact.dispose();
    address.dispose();
    _cadreSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cadre = ref.watch(cadreProvider);
    final isLoading = cadre is AsyncLoading;

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
                  controller: fonction,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Fonction",
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
                  controller: address,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Adresse",
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
