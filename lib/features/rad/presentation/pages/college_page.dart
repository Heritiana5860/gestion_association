import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/build_loading.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/rad/header_card_rad.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/widget_provider/build_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/college/get_college_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/college/college_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/college/college_dialog.dart';

class CollegePage extends ConsumerStatefulWidget {
  const CollegePage({super.key});

  @override
  ConsumerState<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends ConsumerState<CollegePage> {
  final searchController = TextEditingController();
  String searchText = "";

  void _openCollegeDialog() {
    showDialog(context: context, builder: (context) => CollegeDialog());
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
    final colleges = ref.watch(collegeDataProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: AppText(label: "Collège des doyens"),
        centerTitle: true,
      ),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "college-btn",
        icon: Icons.person_pin_rounded,
        onPressed: _openCollegeDialog,
      ),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            HeaderCardRAD(
              title: "Les collèges des doyens de l'association",
              description:
                  "Le collège des doyens regroupe les anciens membres expérimentés de l'association. Ils apportent sagesse, conseils et accompagnement, afin de guider les plus jeunes et préserver la continuité des valeurs associatives.",
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

            colleges.when(
              data: (items) {
                final filteredItems = items.where((item) {
                  final nomMatch = item.nom.toLowerCase().contains(searchText);
                  final contactMatch = item.contact.toLowerCase().contains(
                    searchText,
                  );
                  final fonctionMatch = item.nomPromotion
                      .toLowerCase()
                      .contains(searchText);
                  final addressMatch = item.address.toLowerCase().contains(
                    searchText,
                  );

                  return nomMatch ||
                      contactMatch ||
                      fonctionMatch ||
                      addressMatch;
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
                          label: "Aucun collège des doyens trouvé",
                          icon: Icons.people_outline_rounded,
                        ),
                      ),
                    ),
                  );
                }

                return SliverList.separated(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return CollegeCard(item: item);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                );
              },
              error: (error, _) => BuildError(error: error),
              loading: () => BuildLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
