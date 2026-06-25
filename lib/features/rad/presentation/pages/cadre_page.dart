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
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/cadre/fetch_cadre_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/cadre/cadre_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/widgets/cadre/cadre_dialog.dart';

class CadrePage extends ConsumerStatefulWidget {
  const CadrePage({super.key});

  @override
  ConsumerState<CadrePage> createState() => _CadrePageState();
}

class _CadrePageState extends ConsumerState<CadrePage> {
  final searchController = TextEditingController();
  String searchText = "";

  void _openCadreDialog() {
    showDialog(context: context, builder: (context) => CadreDialog());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cadres = ref.watch(fetchCadre);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(title: AppText(label: "Jeune cadre"), centerTitle: true),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "cadre-btn",
        icon: Icons.person_pin_rounded,
        onPressed: _openCadreDialog,
      ),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            HeaderCardRAD(
              title: "Les jeunes cadre de l'association",
              description:
                  "Le jeune cadre est un ancien membre ayant terminé ses études et engagé dans la vie professionnelle. Il reste proche de l'association, apporte son expérience et soutient les activités pour guider les plus jeunes.",
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

            cadres.when(
              data: (items) {
                final filteredItems = items.where((item) {
                  final nomMatch = item.nom.toLowerCase().contains(searchText);
                  final contactMatch = item.contact.toLowerCase().contains(
                    searchText,
                  );
                  final fonctionMatch = item.fonction.toLowerCase().contains(
                    searchText,
                  );
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
                          label: "Aucun jeune cadre trouvé",
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

                    return CadreCard(item: item);
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
