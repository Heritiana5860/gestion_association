import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/add_cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/add_member_dialog.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/action_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';

class ActionRow extends StatefulWidget {
  const ActionRow({super.key, required this.member});
  final MemberEntity member;

  @override
  State<ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<ActionRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            icon: Icons.account_balance_wallet,
            label: 'Cotisation',
            isPrimary: true,
            onTap: () {
              _payCotisation(id: widget.member.id);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ActionButton(
            icon: Icons.edit_outlined,
            label: 'Modifier',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AddMemberDialog(member: widget.member),
              );
            },
          ),
        ),
      ],
    );
  }

  void _payCotisation({required int? id}) {
    showDialog(
      context: context,
      builder: (context) => PayCotisationDialog(id: id),
    );
  }
}

class PayCotisationDialog extends ConsumerStatefulWidget {
  const PayCotisationDialog({super.key, this.id});

  final int? id;

  @override
  ConsumerState<PayCotisationDialog> createState() =>
      _PayCotisationDialogState();
}

class _PayCotisationDialogState extends ConsumerState<PayCotisationDialog> {
  final formKey = GlobalKey<FormState>();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pay = ref.watch(payCotisation);
    final isLoading = pay is AsyncLoading;

    ref.listen<AsyncValue<void>>(payCotisation, (previous, next) {
      next.whenOrNull(
        data: (data) {
          ref.read(cotisationDataProvider.notifier).refresh();
          ref.read(cotisationStats.notifier).refresh();
          amount.clear();
          context.pop();
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.red,
              content: AppText(label: "$error", color: AppColor.white),
            ),
          );
        },
      );
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogHeader(headerTitle: "Obligation"),
              SizedBox(height: 12.h),

              AppInput(
                controller: amount,
                keyboardType: TextInputType.number,
                labelText: "Montant",
                validator: (p0) {
                  if (p0 == null) {
                    return ValidatorText.obligatorField;
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.h),

              AppButton(
                label: isLoading ? "En cours..." : "Enregistrer",
                onPressed: isLoading ? null : _saveBill,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  void _saveBill() {
    if (formKey.currentState!.validate()) {
      final model = AddCotisationModel(
        id: widget.id!,
        amount: double.parse(amount.text),
      );

      ref.read(payCotisation.notifier).newCotisation(model: model);
    }
  }
}
