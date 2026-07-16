import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/card/card_style.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/widgets/dialog_material.dart';

class ListMaterialCadre extends StatelessWidget {
  const ListMaterialCadre({super.key, required this.item});

  final MaterialEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DialogMaterial(entity: item),
        );
      },
      child: CardStyle(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: AppColor.blue.withValues(alpha: 0.1),
              child: AppText(
                label: item.nom.isNotEmpty ? item.nom[0].toUpperCase() : "?",
                color: AppColor.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  AppText(
                    label: item.nom,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),

                  Row(
                    children: [
                      Icon(Icons.numbers, color: AppColor.grey, size: 16.sp),
                      SizedBox(width: 6.w),
                      AppText(
                        label: "Nombre de matériel : ",
                        color: AppColor.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      Expanded(
                        child: AppText(
                          label: "${item.nombreMateriel}",
                          fontWeight: FontWeight.w800,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),

                  if (item.description!.isNotEmpty) ...[
                    Divider(color: AppColor.scaffoldBackground, height: 12.h),
                    AppText(
                      label: item.description!,
                      color: AppColor.textDescription,
                      fontSize: 12.sp,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
