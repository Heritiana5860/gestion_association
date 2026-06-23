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
                  return SliverAnimatedGrid(
                    initialItemCount: filteredItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index, animation) {
                      final item = filteredItems[index];

                      return ScaleTransition(
                        scale: animation,
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            spacing: 6.h,
                            children: [
                              CircleAvatar(
                                radius: 24.r,
                                backgroundColor: AppColor.blue.withValues(
                                  alpha: 0.1,
                                ),
                                child: Center(
                                  child: AppText(
                                    label: item.nom[0],
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              AppText(
                                label: item.nom,
                                fontWeight: FontWeight.w700,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              BuildInfo(
                                label: item.year,
                                icon: Icons.date_range,
                              ),
                              BuildInfo(label: item.contact, icon: Icons.phone),
                              BuildInfo(
                                label: item.bio.isEmpty ? "..." : item.bio,
                                icon: Icons.star_purple500_rounded,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
