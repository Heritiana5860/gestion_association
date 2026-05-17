import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/donut_chart.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/paid_badge.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/status_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/bar_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/stat_card.dart';

class CotisationStatsCard extends StatelessWidget {
  final CotisationStatsEntity stat;

  const CotisationStatsCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                label: "Cotisations",
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              PaidBadge(percentage: stat.paidPercentage ?? 0),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              DonutChart(
                paid: stat.paidPercentage ?? 0,
                notPaid: stat.notPaidPercentage ?? 0,
                total: stat.total ?? 0,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    BarRow(
                      label: "Payés",
                      pct: (stat.paidPercentage ?? 0) / 100,
                      color: AppColor.green,
                    ),
                    SizedBox(height: 8.h),
                    BarRow(
                      label: "Non payés",
                      pct: (stat.notPaidPercentage ?? 0) / 100,
                      color: AppColor.red,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              StatCard(
                icon: Icons.check_circle_rounded,
                value: "${stat.paid}",
                label: "Payés",
                color: AppColor.green,
              ),
              SizedBox(width: 8.w),
              StatCard(
                icon: Icons.cancel_rounded,
                value: "${stat.notPaid}",
                label: "Non payés",
                color: AppColor.red,
              ),
            ],
          ),

          SizedBox(height: 14.h),
          Divider(color: AppColor.lightGrey, thickness: 1),
          SizedBox(height: 10.h),

          AppText(
            label: "Détail par statut",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textDescription,
          ),

          SizedBox(height: 10.h),

          StatusRow(
            icon: Icons.workspace_premium_rounded,
            label: "Doyen(ne)s",
            color: Colors.orange,
            paid: stat.doyenPaid ?? 0,
            notPaid: stat.doyenNotPaid ?? 0,
            paidPct: stat.doyensPaidPercentage ?? 0,
            notPaidPct: stat.doyensNotPaidPercentage ?? 0,
          ),
          SizedBox(height: 10.h),
          StatusRow(
            icon: Icons.star_rounded,
            label: "Ancien(ne)s",
            color: AppColor.blue,
            paid: stat.anciensPaid ?? 0,
            notPaid: stat.anciensNotPaid ?? 0,
            paidPct: stat.anciensPaidPercentage ?? 0,
            notPaidPct: stat.anciensNotPaidPercentage ?? 0,
          ),
          SizedBox(height: 10.h),
          StatusRow(
            icon: Icons.auto_awesome,
            label: "Novices",
            color: AppColor.green,
            paid: stat.novicesPaid ?? 0,
            notPaid: stat.novicesNotPaid ?? 0,
            paidPct: stat.novicesPaidPercentage ?? 0,
            notPaidPct: stat.novicesNotPaidPercentage ?? 0,
          ),
        ],
      ),
    );
  }
}
