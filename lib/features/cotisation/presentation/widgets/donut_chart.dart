import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class DonutChart extends StatelessWidget {
  final double paid;
  final double notPaid;
  final int total;
  const DonutChart({
    super.key,
    required this.paid,
    required this.notPaid,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 90.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 28.r,
              sections: [
                PieChartSectionData(
                  value: paid,
                  color: AppColor.green,
                  radius: 18.r,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: notPaid,
                  color: AppColor.red.withValues(alpha: 0.75),
                  radius: 18.r,
                  showTitle: false,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                label: "$total",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                label: "total",
                fontSize: 9.sp,
                color: AppColor.textDescription,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
