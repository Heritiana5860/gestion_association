import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/member_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/rad_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/member_data_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/ref_listen_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_checkbox.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_dropdown.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_add_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_detail_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';

class AddMemberDialog extends ConsumerStatefulWidget {
  const AddMemberDialog({super.key, this.member});

  final MemberEntity? member;

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

  late final ProviderSubscription<AsyncValue<void>> _addMemberSubscription;

  String selectedLevel = "L1";
  String selectedStatut = "Novice";
  bool? isInside = false;

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }

  void _newMember() {
    try {
      final entity = MemberEntity(
        fullName: fullNameController.text.trim(),
        numberPhone: numberPhoneController.text.trim(),
        isInside: isInside ?? false,
        cde: cdeController.text.trim(),
        address: adresseController.text.trim(),
        school: etablissementController.text.trim(),
        level: selectedLevel,
        statut: selectedStatut.toUpperCase(),
      );
      if (formKey.currentState!.validate()) {
        ref.read(newMemberProvider.notifier).addMember(entity: entity);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            label: "Une erreur est survenu!",
            color: AppColor.red,
          ),
        ),
      );
    }
  }

  void _updateMember() {
    if (!formKey.currentState!.validate()) return;

    final entity = MemberEntity(
      fullName: fullNameController.text.trim(),
      numberPhone: numberPhoneController.text.trim(),
      isInside: isInside as bool,
      cde: cdeController.text.trim(),
      address: adresseController.text.trim(),
      school: etablissementController.text.trim(),
      level: selectedLevel,
      statut: selectedStatut.toUpperCase(),
    );

    ref
        .read(newMemberProvider.notifier)
        .updateMember(id: widget.member!.id ?? 0, entity: entity);
  }

  @override
  void initState() {
    super.initState();
    final m = widget.member;
    if (m != null) {
      fullNameController.text = m.fullName;
      numberPhoneController.text = m.numberPhone;
      cdeController.text = m.cde;
      adresseController.text = m.address ?? "";
      etablissementController.text = m.school ?? "";
      selectedLevel = m.level ?? "";
      selectedStatut = _capitalize(m.statut.toLowerCase());
      isInside = m.isInside;
    }

    _addMemberSubscription = ref.listenManual<AsyncValue<void>>(
      newMemberProvider,
      (previous, next) {
        next.whenOrNull(
          data: (_) async {
            if (!context.mounted) return;
            context.pop();

            ref.invalidate(detailProvider);
            if (widget.member?.id != null) {
              ref.invalidate(detailProvider(widget.member!.id!));
            }

            await Future.wait([
              ref.read(memberDataProvider.notifier).refresh(),
              ref.read(cotisationDataProvider.notifier).refresh(),
              ref.read(memberDataStats.notifier).refresh(),
              ref.read(cotisationStats.notifier).refresh(),
            ]);
          },
          error: (error, _) => RefListenError.errorListenProvider(
            context: context,
            error: error,
          ),
        );
      },
    );
  }

  bool get _isEditing => widget.member != null;

  @override
  void dispose() {
    fullNameController.dispose();
    numberPhoneController.dispose();
    cdeController.dispose();
    adresseController.dispose();
    etablissementController.dispose();

    _addMemberSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newMember = ref.watch(newMemberProvider);
    final isLoading = newMember is AsyncLoading;

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
              spacing: 12.h,
              children: [
                // Header
                DialogHeader(headerTitle: MemberText.title),

                // Body
                AppInput(
                  labelText: MemberText.fullName,
                  controller: fullNameController,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),

                AppInput(
                  labelText: MemberText.contact,
                  controller: numberPhoneController,
                  keyboardType: TextInputType.phone,
                  enabled: !isLoading,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),

                AppInput(
                  labelText: MemberText.cde,
                  controller: cdeController,
                  keyboardType: TextInputType.visiblePassword,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),

                AppInput(
                  labelText: MemberText.address,
                  controller: adresseController,
                  keyboardType: TextInputType.visiblePassword,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),

                AppInput(
                  labelText: MemberText.school,
                  controller: etablissementController,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null) {
                      return ValidatorText.obligatorField;
                    }
                    return null;
                  },
                ),

                AppDropdown(
                  labelText: MemberText.level,
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

                AppDropdown(
                  labelText: MemberText.statut,
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

                AppCheckbox(
                  title: MemberText.residance,
                  value: isInside,
                  onChanged: (value) {
                    setState(() {
                      isInside = value;
                    });
                  },
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
                        : (_isEditing ? _updateMember : _newMember),
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
