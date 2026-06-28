import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/build_loading.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/rad/header_card_rad.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/widget_provider/build_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/get_honneur_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/honneur/honneur_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/honneur/honneur_dialog.dart';

class HonneurPage extends ConsumerStatefulWidget {
  const HonneurPage({super.key});

  @override
  ConsumerState<HonneurPage> createState() => _HonneurPageState();
}

class _HonneurPageState extends ConsumerState<HonneurPage> {
  final searchController = TextEditingController();
  String searchText = "";

  void _openHonneurDialog() {
    showDialog(context: context, builder: (context) => HonneurDialog());
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
    final honneurs = ref.watch(getHonneurs);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: AppText(label: "President d'Honneur"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "honneur-btn",
        icon: Icons.person_pin_rounded,
        onPressed: _openHonneurDialog,
      ),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            HeaderCardRAD(
              title: "Les présidents d'honneur de l'association",
              description:
                  "Le président d'honneur est une personnalité choisie pour représenter et soutenir l'association. Il n'a pas de rôle exécutif au quotidien, mais apporte prestige, conseils et visibilité à nos activités.",
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

            honneurs.when(
              data: (items) {
                final filteredItems = items.where((item) {
                  final nomMatch = item.nom.toLowerCase().contains(searchText);
                  final contactMatch = item.contact.toLowerCase().contains(
                    searchText,
                  );
                  final fonctionMatch = item.fonction.toLowerCase().contains(
                    searchText,
                  );
                  final yearMatch = item.year.toLowerCase().contains(
                    searchText,
                  );
                  final addressMatch = item.address.toLowerCase().contains(
                    searchText,
                  );

                  return nomMatch ||
                      contactMatch ||
                      fonctionMatch ||
                      yearMatch ||
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
                          label: "Aucun président d'honneur trouvé",
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

                    return HonneurCard(item: item);
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
