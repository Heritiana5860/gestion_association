import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/rad/header_card_rad.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/get_president_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/president/president_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/president/president_dialog.dart';

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
              HeaderCardRAD(
                title: "Les présidents de l'association",
                description:
                    "Le président est le représentant légal de l'association. Élu par les membres, il assure la direction, veille au respect des statuts et porte la voix de l'association auprès des partenaires extérieurs.",
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

                      return PresidentCard(item: item);
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
