import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_filters_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/choice_chip.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/sheet_section.dart';

class FilterBottomSheet extends StatefulWidget {
  final MemberFiltersModel current;
  final ValueChanged<MemberFiltersModel> onApply;

  const FilterBottomSheet({
    super.key,
    required this.current,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  late MemberFiltersModel _draft;

  static const _statuts = ["NOVICE", "ANCIEN(NE)", "DOYEN(NE)"];
  static const _levels = ["L1", "L2", "L3", "M1", "M2"];

  @override
  void initState() {
    super.initState();
    _draft = widget.current;
  }

  void _apply() {
    widget.onApply(_draft);
    Navigator.pop(context);
  }

  void _reset() => setState(() => _draft = const MemberFiltersModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                label: "Filtres",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              TextButton(
                onPressed: _reset,
                child: Text(
                  "Réinitialiser",
                  style: TextStyle(color: AppColor.red, fontSize: 13.sp),
                ),
              ),
            ],
          ),

          Divider(height: 24.h),

          SheetSection(
            title: "Statut",
            child: Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: _statuts.map((s) {
                final selected = _draft.statut == s;
                return ChoiceChipCard(
                  label: s,
                  selected: selected,
                  onTap: () => setState(() {
                    _draft = _draft.copyWith(statut: selected ? "TOUS" : s);
                  }),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 20.h),

          SheetSection(
            title: "Niveau",
            child: Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: _levels.map((l) {
                final selected = _draft.level == l;
                return ChoiceChipCard(
                  label: l,
                  selected: selected,
                  onTap: () => setState(() {
                    _draft = _draft.copyWith(level: selected ? "TOUS" : l);
                  }),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 20.h),

          SheetSection(
            title: "Localisation",
            child: Row(
              children: [
                ChoiceChipCard(
                  label: "Interne",
                  icon: Icons.home_outlined,
                  selected: _draft.isInside == true,
                  onTap: () => setState(() {
                    _draft = _draft.copyWith(
                      isInside: _draft.isInside == true ? null : true,
                    );
                  }),
                ),
                SizedBox(width: 8.w),
                ChoiceChipCard(
                  label: "Externe",
                  icon: Icons.location_on_outlined,
                  selected: _draft.isInside == false,
                  onTap: () => setState(() {
                    _draft = _draft.copyWith(
                      isInside: _draft.isInside == false ? null : false,
                    );
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),

          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.blue,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "Appliquer les filtres",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
