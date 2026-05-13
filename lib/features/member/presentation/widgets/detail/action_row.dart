import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/add_member_dialog.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/action_button.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({super.key, required this.member});
  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            icon: Icons.account_balance_wallet,
            label: 'Cotisation',
            isPrimary: true,
            onTap: () {},
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ActionButton(
            icon: Icons.edit_outlined,
            label: 'Modifier',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AddMemberDialog(member: member),
              );
            },
          ),
        ),
      ],
    );
  }
}
