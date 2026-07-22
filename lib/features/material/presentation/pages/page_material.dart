import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/provider_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_circular.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/rad/header_card_rad.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/warning.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/role_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/providers/list_material_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/widgets/dialog_material.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/presentation/widgets/list_material_cadre.dart';

class PageMaterial extends ConsumerStatefulWidget {
  const PageMaterial({super.key});

  @override
  ConsumerState<PageMaterial> createState() => _PageMaterialState();
}

class _PageMaterialState extends ConsumerState<PageMaterial> {
  final searchController = TextEditingController();
  String searchText = "";

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

  void _openMaterialDialog() {
    showDialog(context: context, builder: (context) => DialogMaterial());
  }

  @override
  Widget build(BuildContext context) {
    final listMaterials = ref.watch(listMaterialProvider);
    final role = ref.watch(roleUserProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: const AppText(label: 'Matériel(s)', fontWeight: FontWeight.w600),
        centerTitle: true,
      ),
      floatingActionButton: ButtonFoatingCard(
        heroTag: "material-btn",
        icon: Icons.post_add,
        onPressed: () {
          role == "Membre" ? messageRoleMember(context) : _openMaterialDialog();
        },
      ),
      body: Padding(
        padding: globalPadding(),
        child: CustomScrollView(
          slivers: [
            HeaderCardRAD(
              title: "Matériels de l'association",
              description:
                  "Les matériels regroupent les biens et équipements utilisés pour les activités de l'association. Ils sont gérés collectivement afin de soutenir l'organisation des événements et préserver le patrimoine associatif.",
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

            listMaterials.when(
              data: (items) {
                final filteredItems = items.where((item) {
                  final nomMatch = item.nom.toLowerCase().contains(searchText);

                  return nomMatch;
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
                          label: "Aucune matériel trouvée",
                          icon: Icons.build,
                        ),
                      ),
                    ),
                  );
                }

                return SliverList.separated(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return ListMaterialCadre(item: item);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                );
              },
              error: (error, _) {
                return SliverFillRemaining(
                  child: errorProvider(context: context, error: error),
                );
              },
              loading: () => SliverFillRemaining(child: AppCircular()),
            ),
          ],
        ),
      ),
    );
  }
}
