import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/add_cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_detail_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';

class PayCotisationDialog extends ConsumerStatefulWidget {
  const PayCotisationDialog({super.key, this.id, this.initialAmount});

  final int? id;
  final double? initialAmount;

  @override
  ConsumerState<PayCotisationDialog> createState() =>
      _PayCotisationDialogState();
}

class _PayCotisationDialogState extends ConsumerState<PayCotisationDialog> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController amount;

  @override
  void initState() {
    super.initState();
    String initialText = widget.initialAmount != null
        ? widget.initialAmount.toString()
        : '';
    amount = TextEditingController(text: initialText);
  }

  @override
  Widget build(BuildContext context) {
    final pay = ref.watch(payCotisation);
    final isLoading = pay is AsyncLoading;

    ref.listen<AsyncValue<void>>(payCotisation, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (widget.id != null) {
            ref.invalidate(detailProvider(widget.id!));
          }

          ref.read(cotisationDataProvider.notifier).refresh();
          ref.read(cotisationStats.notifier).refresh();

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
    final selectedYear = ref.read(selectedYearProvider) ?? "2026";
    if (formKey.currentState!.validate()) {
      final model = AddCotisationModel(
        id: widget.id!,
        amount: double.parse(amount.text),
        year: selectedYear,
      );

      ref.read(payCotisation.notifier).newCotisation(model: model);
    }
  }
}
