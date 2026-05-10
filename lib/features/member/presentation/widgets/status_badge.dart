import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final String statut;
  const StatusBadge({super.key, required this.statut});

  Color get _color => switch (statut) {
    "NOVICE" => Colors.orange,
    "ANCIEN(NE)" => Colors.green,
    "DOYEN(NE)" => Colors.purple,
    _ => Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        statut,
        style: TextStyle(
          fontSize: 9.sp,
          color: _color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
