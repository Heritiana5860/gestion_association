import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/cotisation_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/rad_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/constant_text/validator_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/ref_listen_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/selected_year_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/add_cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_detail_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
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

  late final ProviderSubscription<AsyncValue<void>> _payCotisationSubscription;

  @override
  void initState() {
    super.initState();
    String initialText = widget.initialAmount != null
        ? widget.initialAmount.toString()
        : '';
    amount = TextEditingController(text: initialText);

    _payCotisationSubscription = ref.listenManual<AsyncValue<void>>(
      payCotisation,
      (_, next) {
        next.whenOrNull(
          data: (data) async {
            ref.invalidate(detailProvider(widget.id!));

            await Future.wait([
              ref.read(memberDataProvider.notifier).refresh(),
              ref.read(cotisationDataProvider.notifier).refresh(),
              ref.read(cotisationStats.notifier).refresh(),
            ]);

            if (mounted) {
              context.pop();
            }
          },
          error: (error, _) => RefListenError.errorListenProvider(
            context: context,
            error: error,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pay = ref.watch(payCotisation);
    final isLoading = pay is AsyncLoading;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogHeader(headerTitle: CotisationText.title),
              SizedBox(height: 12.h),

              AppInput(
                controller: amount,
                keyboardType: TextInputType.number,
                labelText: CotisationText.montant,
                validator: (p0) {
                  if (p0 == null) {
                    return ValidatorText.obligatorField;
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.h),

              AppButton(
                label: isLoading ? RadText.saveEnCours : RadText.save,
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
    _payCotisationSubscription.close();
    super.dispose();
  }

  void _saveBill() {
    final selectedYear = ref.read(selectedYearProvider) ?? "2026";
    if (formKey.currentState!.validate()) {
      final entity = AddCotisationEntity(
        id: widget.id!,
        amount: double.parse(amount.text),
        year: selectedYear,
      );

      ref.read(payCotisation.notifier).newCotisation(entity: entity);
    }
  }
}
