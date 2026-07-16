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
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/post_material_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';

class DialogMaterial extends ConsumerStatefulWidget {
  const DialogMaterial({super.key, this.entity});

  final MaterialEntity? entity;

  @override
  ConsumerState<DialogMaterial> createState() => _DialogMaterialState();
}

class _DialogMaterialState extends ConsumerState<DialogMaterial> {
  final formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final description = TextEditingController();
  final nombreMateriel = TextEditingController();

  late final ProviderSubscription<AsyncValue<void>> _materialSubscription;

  @override
  void initState() {
    super.initState();
    final i = widget.entity;
    if (i != null) {
      nom.text = i.nom;
      description.text = i.description ?? "";
      nombreMateriel.text = (i.nombreMateriel ?? 0).toString();
    }

    _materialSubscription = ref.listenManual(materialProvider, (
      previous,
      next,
    ) {
      if (previous is AsyncLoading && next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.green,
            content: AppText(label: RadText.saveSucces, color: AppColor.white),
          ),
        );

        if (context.mounted) context.pop();
      }

      if (next is AsyncError) {
        RefListenError.errorListenProvider(context: context, error: next.error);
      }
    });
  }

  @override
  void dispose() {
    nom.dispose();
    description.dispose();
    _materialSubscription.close();
    super.dispose();
  }

  void _newMaterial() {
    if (!formKey.currentState!.validate()) return;

    final entity = MaterialEntity(
      nom: nom.text,
      description: description.text,
      nombreMateriel: int.parse(nombreMateriel.text),
    );

    ref.read(materialProvider.notifier).addMaterialProvider(entity);
  }

  bool get _isEditing => widget.entity != null;

  void _updateMaterial() {
    if (!formKey.currentState!.validate()) return;

    final entity = MaterialEntity(
      nom: nom.text,
      description: description.text,
      nombreMateriel: int.parse(nombreMateriel.text),
    );

    ref
        .read(materialProvider.notifier)
        .updateMaterialProvider(id: widget.entity!.id ?? 0, entity: entity);
  }

  @override
  Widget build(BuildContext context) {
    final mat = ref.watch(materialProvider);
    final isLoading = mat is AsyncLoading;

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
                DialogHeader(headerTitle: "Nouveau matériel"),

                AppInput(
                  controller: nom,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Nom de matériel",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ValidatorText.obligatorField;
                    }

                    return null;
                  },
                ),

                AppInput(
                  controller: nombreMateriel,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  labelText: "Nombre de matériels",
                ),

                AppInput(
                  controller: description,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  labelText: "Description",
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
                        : (_isEditing ? _updateMaterial : _newMaterial),
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
