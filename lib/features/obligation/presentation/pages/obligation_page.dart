import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/obligation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/widgets/form_obligation_dialog.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/widgets/obligation_list_card.dart';

class ObligationPage extends ConsumerStatefulWidget {
  const ObligationPage({super.key});

  @override
  ConsumerState<ObligationPage> createState() => _ObligationPageState();
}

class _ObligationPageState extends ConsumerState<ObligationPage> {
  void _openDialog() {
    showDialog(
      context: context,
      builder: (context) => const FormObligationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final obligations = ref.watch(obligationsProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.scaffoldBackground,
        centerTitle: true,

        title: AppText(
          label: "Obligations",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),

        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),

      floatingActionButton: ButtonFoatingCard(
        heroTag: "obligation-btn",
        icon: Icons.add_rounded,
        onPressed: _openDialog,
      ),

      body: Padding(
        padding: globalPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColor.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: AppColor.blue,
                          size: 22.sp,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: AppText(
                          label: "Adhésion et cotisations annuelles",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  AppText(
                    label:
                        "Cette section permet de définir les montants des obligations pour chaque catégorie de membre selon l’année académique.\n\n"
                        "Les montants sont répartis selon :\n"
                        "• les doyens et anciens membres\n"
                        "• les novices\n"
                        "• les membres internes\n"
                        "• les membres externes",
                    color: AppColor.textDescription,
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),

            // Section title
            AppText(
              label: "Liste des obligations",
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 12.h),

            // Content
            Expanded(
              child: obligations.when(
                data: (obs) {
                  if (obs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 48.sp,
                            color: AppColor.textDescription,
                          ),

                          SizedBox(height: 12.h),

                          AppText(
                            label: "Aucune obligation disponible.",
                            color: AppColor.textDescription,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: AppColor.blue,
                    onRefresh: () =>
                        ref.read(obligationsProvider.notifier).refresh(),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: obs.length,

                      separatorBuilder: (_, _) => SizedBox(height: 0.h),

                      itemBuilder: (context, index) {
                        final item = obs[index];

                        return ObligationListCard(item: item);
                      },
                    ),
                  );
                },

                error: (error, _) {
                  debugPrint("error: $error");

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 48.sp,
                          color: AppColor.red,
                        ),

                        SizedBox(height: 12.h),

                        AppText(
                          label:
                              "Une erreur est survenue lors de la connexion au serveur.",
                          color: AppColor.textDescription,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },

                loading: () => Center(
                  child: CircularProgressIndicator(color: AppColor.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
