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
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/get_honneur_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/honneur_notifier.dart';

class HonneurDialog extends ConsumerStatefulWidget {
  const HonneurDialog({super.key, this.item});

  final HonneurEntity? item;

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

  late final ProviderSubscription<AsyncValue<void>> _honneurSubscription;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nom.text = widget.item!.nom;
      contact.text = widget.item!.contact;
      fonction.text = widget.item!.fonction;
      mandat.text = widget.item!.year;
      address.text = widget.item!.address;
    }

    _honneurSubscription = ref.listenManual<AsyncValue<void>>(honneurProvider, (
      _,
      next,
    ) {
      next.whenOrNull(
        data: (_) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.green,
              content: AppText(
                label: _isEditing
                    ? RadText.modifSucces
                    : "Président d'honneur ajouté avec succès!",
                color: AppColor.white,
              ),
            ),
          );

          await ref.read(getHonneurs.notifier).refresh();

          if (mounted) {
            context.pop();
          }
        },
        error: (error, _) =>
            RefListenError.errorListenProvider(context: context, error: error),
      );
    });
  }

  @override
  void dispose() {
    nom.dispose();
    contact.dispose();
    fonction.dispose();
    mandat.dispose();
    address.dispose();
    _honneurSubscription.close();
    super.dispose();
  }

  void _createHonneur() {
    if (!formKey.currentState!.validate()) return;

    final entity = HonneurEntity(
      nom: nom.text,
      fonction: fonction.text,
      contact: contact.text,
      year: mandat.text,
      address: address.text,
    );

    ref.read(honneurProvider.notifier).createHonneur(entity);
  }

  void _updateHonneur() {
    if (!formKey.currentState!.validate()) return;

    final entity = HonneurEntity(
      nom: nom.text,
      fonction: fonction.text,
      contact: contact.text,
      year: mandat.text,
      address: address.text,
    );

    ref
        .read(honneurProvider.notifier)
        .honneurUpdateProvider(id: widget.item!.id!, entity: entity);
  }

  bool get _isEditing => widget.item != null;

  @override
  Widget build(BuildContext context) {
    final honneurs = ref.watch(honneurProvider);
    final isLoading = honneurs is AsyncLoading;

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
                  controller: mandat,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  labelText: "Année de mandat",
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
                        : (_isEditing ? _updateHonneur : _createHonneur),
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
