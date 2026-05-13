import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class FilterIconButton extends StatelessWidget {
  final int activeCount;
  final VoidCallback onTap;

  const FilterIconButton({
    super.key,
    required this.activeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: activeCount > 0
                  ? AppColor.blue.withValues(alpha: 0.12)
                  : AppColor.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: activeCount > 0
                    ? AppColor.blue.withValues(alpha: 0.4)
                    : Colors.grey.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: activeCount > 0 ? AppColor.blue : Colors.grey,
              size: 22.sp,
            ),
          ),
          if (activeCount > 0)
            Positioned(
              top: -4.h,
              right: -4.w,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$activeCount',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
