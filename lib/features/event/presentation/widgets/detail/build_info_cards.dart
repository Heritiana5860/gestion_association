import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/format/time_format.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/info_tile.dart';

class BuildInfoCards extends StatelessWidget {
  const BuildInfoCards({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoTile(
            icon: Icons.access_time_rounded,
            label: "Début",
            value: formatTime(event.startTime),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: InfoTile(
            icon: Icons.flag_rounded,
            label: "Fin",
            value: formatTime(event.endTime),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: InfoTile(
            icon: Icons.people_outline_rounded,
            label: "Présents",
            value: "${event.members?.length ?? 0}",
            isAccent: true,
          ),
        ),
      ],
    );
  }
}
