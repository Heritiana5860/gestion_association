import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';

class CotisationPage extends ConsumerStatefulWidget {
  const CotisationPage({super.key});

  @override
  ConsumerState<CotisationPage> createState() => _CotisationPageState();
}

class _CotisationPageState extends ConsumerState<CotisationPage> {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cotisation = ref.watch(cotisationDataProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: Padding(
        padding: globalPadding(),
        child: Column(
          spacing: 16.h,
          children: [
            AppInput(
              labelText: "Recherche...",
              controller: search,
              keyboardType: TextInputType.text,
            ),

            cotisation.when(
              data: (cotis) {
                if (cotis.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 48.r,
                            color: AppColor.blue.withValues(alpha: 0.4),
                          ),
                          AppText(
                            label: "Aucune cotisation enregistrée",
                            fontSize: 14.sp,
                            color: AppColor.blue.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: cotis.length,
                    itemBuilder: (context, index) {
                      final item = cotis[index];

                      return CotisationCard(item: item);
                    },
                  ),
                );
              },
              error: (error, _) => Center(
                child: AppText(label: "Erreur: $error", color: AppColor.red),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(color: AppColor.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}

class CotisationCard extends StatelessWidget {
  final CotisationEntity item;

  const CotisationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.blue.withValues(alpha: 0.1),
          radius: 18.r,
          child: AppText(
            label: item.member.fullName.length >= 2
                ? item.member.fullName.substring(0, 2)
                : item.member.fullName,
            fontWeight: FontWeight.w700,
          ),
        ),
        title: AppText(
          label: item.member.fullName,
          fontWeight: FontWeight.w700,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildItem(label: "Montant: ", value: "${item.amount} Ar"),
            BuildItem(label: "Année: ", value: "${item.year}"),
            BuildItem(
              label: "Dernier mise à jour: ",
              value: item.isUpdate.isNotEmpty
                  ? DateFormat(
                      'dd/MM/yyyy',
                    ).format(DateTime.parse(item.isUpdate))
                  : '-',
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            if (!context.mounted) return;
            context.pushNamed("member-detail", extra: item.member.id);
          },
          icon: const Icon(Icons.visibility_rounded),
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({super.key, required this.label, required this.value, this.color = AppColor.black});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(label: label),
        AppText(
          label: value,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
