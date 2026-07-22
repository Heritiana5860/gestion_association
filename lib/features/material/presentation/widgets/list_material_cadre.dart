import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/card/card_style.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/warning.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/role_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/post_material_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/widgets/dialog_material.dart';

class ListMaterialCadre extends ConsumerStatefulWidget {
  const ListMaterialCadre({super.key, required this.item});

  final MaterialEntity item;

  @override
  ConsumerState<ListMaterialCadre> createState() => _ListMaterialCadreState();
}

class _ListMaterialCadreState extends ConsumerState<ListMaterialCadre> {
  bool _isRemoved = false;

  Future<bool> _confirmDelete(BuildContext context) async {
    final role = ref.read(roleUserProvider);

    bool? result = false;

    if (role == "Membre") {
      messageRoleMember(context);
      return false;
    }

    result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        backgroundColor: AppColor.scaffoldBackground,
        insetPadding: EdgeInsets.all(12.r),
        title: const AppText(
          label: "Supprimer le matériel",
          fontWeight: FontWeight.w700,
        ),
        content: AppText(
          label:
              "Voulez-vous vraiment supprimer \"${widget.item.nom}\" ? Cette action est irréversible.",
          fontSize: 13.sp,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const AppText(
              label: "Annuler",
              color: AppColor.textDescription,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: AppText(
              label: "Supprimer",
              color: AppColor.red,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Dès que le dismiss est confirmé, on masque immédiatement la carte
    // pour éviter que le Dismissible reste dans l'arbre après son animation.
    if (_isRemoved) {
      return const SizedBox.shrink();
    }

    return Dismissible(
      key: ValueKey(widget.item.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) {
        return _confirmDelete(context);
      },
      onDismissed: (_) {
        setState(() => _isRemoved = true);
        ref
            .read(materialProvider.notifier)
            .deleteMaterialProvider(widget.item.id!);
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColor.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.delete, color: AppColor.red, size: 26.sp),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DialogMaterial(entity: widget.item),
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
                  label: widget.item.nom.isNotEmpty
                      ? widget.item.nom[0].toUpperCase()
                      : "?",
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
                      label: widget.item.nom,
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
                            label: "${widget.item.nombreMateriel}",
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),

                    if (widget.item.description!.isNotEmpty) ...[
                      Divider(color: AppColor.scaffoldBackground, height: 12.h),
                      AppText(
                        label: widget.item.description!,
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
      ),
    );
  }
}
