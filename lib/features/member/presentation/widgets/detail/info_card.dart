import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_row_widget.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.rows});
  final List<InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Column(
        children: rows
            .asMap()
            .entries
            .map(
              (e) => Column(
                children: [
                  if (e.key > 0)
                    Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: Colors.black.withValues(alpha: 0.08),
                    ),
                  InfoRowWidget(row: e.value),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
