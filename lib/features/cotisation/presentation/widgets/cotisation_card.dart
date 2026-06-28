import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/build_item.dart';

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
            BuildItem(
              label: "Montant: ",
              value: "${item.amount} Ar",
              color: item.isPaid! ? AppColor.green : AppColor.red,
            ),
            BuildItem(label: "Année: ", value: item.year),
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
