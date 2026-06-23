import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/get_president_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/build_info.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/president_dialog.dart';

class PresidentPage extends ConsumerStatefulWidget {
  const PresidentPage({super.key});

  @override
  ConsumerState<PresidentPage> createState() => _PresidentPageState();
}

class _PresidentPageState extends ConsumerState<PresidentPage> {
  final searchController = TextEditingController();
  String searchText = "";

  void _openPresidentDialog() {
    showDialog(context: context, builder: (context) => PresidentDialog());
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presidentData = ref.watch(getPresidentProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: AppText(label: "Président(s)"), centerTitle: true),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "president-btn",
        icon: Icons.person_pin_rounded,
        onPressed: _openPresidentDialog,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(getPresidentProvider.notifier).refresh(),
        child: Padding(
          padding: globalPadding(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      label: "Les président(s) de l'association",
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                    ),
                    AppText(
                      label:
                          "Le président est le représentant légal de l'association. Il est élu par les membres de l'association.",
                      color: AppColor.textDescription,
                    ),

                    SizedBox(height: 12.h),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: AppInput(
                    controller: searchController,
                    labelText: "Recherche...",
                    prefixIcon: Icons.search,
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => searchController.clear(),
                          )
                        : null,
                  ),
                ),
              ),

              presidentData.when(
                data: (items) {
                  final filteredItems = items.where((item) {
                    final nomMatch = item.nom.toLowerCase().contains(
                      searchText,
                    );
                    final contactMatch = item.contact.toLowerCase().contains(
                      searchText,
                    );
                    final yearMatch = item.year.toLowerCase().contains(
                      searchText,
                    );

                    return nomMatch || contactMatch || yearMatch;
                  }).toList();

                  if (filteredItems.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
                          ),
                          child: EmptyList(
                            label: "Aucun président trouvé",
                            icon: Icons.people_outline_rounded,
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList.separated(
                    itemCount: filteredItems.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      return Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withValues(alpha: 0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. L'avatar à gauche
                            CircleAvatar(
                              radius: 26.r,
                              backgroundColor: AppColor.blue.withValues(
                                alpha: 0.1,
                              ),
                              child: AppText(
                                label: item.nom.isNotEmpty
                                    ? item.nom[0].toUpperCase()
                                    : "?",
                                color: AppColor.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(width: 14.w),

                            // 2. Les informations alignées à droite de l'avatar
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

                                  // Ligne d'infos secondaires côte à côte pour gagner de la place verticalement
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BuildInfo(
                                          label: item.year,
                                          icon: Icons.date_range,
                                        ),
                                      ),
                                      Expanded(
                                        child: BuildInfo(
                                          label: item.contact,
                                          icon: Icons.phone,
                                        ),
                                      ),
                                    ],
                                  ),

                                  if (item.bio.isNotEmpty) ...[
                                    Divider(
                                      color: AppColor.scaffoldBackground,
                                      height: 12.h,
                                    ),
                                    AppText(
                                      label: item.bio,
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
                      );
                    },
                  );
                },
                error: (error, _) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: AppText(label: "$error", color: AppColor.red),
                  ),
                ),
                loading: () => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
