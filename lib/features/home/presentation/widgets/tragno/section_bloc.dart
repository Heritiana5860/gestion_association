import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/tragno/chip_card.dart';

class SectionBloc extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color chipColor;
  final Color chipBg;
  final Color chipBorder;

  const SectionBloc({
    super.key,
    required this.title,
    required this.items,
    required this.chipColor,
    required this.chipBg,
    required this.chipBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label: title.toUpperCase(),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.textDescription,
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: items
              .map(
                (bloc) => ChipCard(
                  label: bloc,
                  color: chipColor,
                  bg: chipBg,
                  border: chipBorder,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
