import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/bar_row.dart';

class StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final int paid;
  final int notPaid;
  final double paidPct;
  final double notPaidPct;

  const StatusRow({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.paid,
    required this.notPaid,
    required this.paidPct,
    required this.notPaidPct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label + icône
          Row(
            children: [
              Icon(icon, size: 14.sp, color: color),
              SizedBox(width: 6.w),
              AppText(
                label: label,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Barre de progression payés
          BarRow(
            label: "Payés ($paid)",
            pct: paidPct / 100,
            color: AppColor.green,
          ),
          SizedBox(height: 6.h),

          // Barre de progression non payés
          BarRow(
            label: "Non payés ($notPaid)",
            pct: notPaidPct / 100,
            color: AppColor.red,
          ),
        ],
      ),
    );
  }
}
