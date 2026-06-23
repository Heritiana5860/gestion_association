import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/cotisation_card.dart';

class CotisationPage extends ConsumerStatefulWidget {
  const CotisationPage({super.key});

  @override
  ConsumerState<CotisationPage> createState() => _CotisationPageState();
}

class _CotisationPageState extends ConsumerState<CotisationPage> {
  final search = TextEditingController();
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    search.addListener(() {
      if (search.text != _lastQuery) {
        _lastQuery = search.text;
        ref.read(cotisationDataProvider.notifier).search(search.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cotisation = ref.watch(cotisationDataProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: Padding(
        padding: globalPadding(),
        child: Column(
          spacing: 16.h,
          children: [
            AppInput(
              labelText: "Recherche...",
              controller: search,
              keyboardType: TextInputType.text,
            ),

            cotisation.when(
              data: (cotis) {
                if (cotis.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64.r,
                            color: AppColor.textDescription.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          AppText(
                            label: "Aucune cotisation enregistrée",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        ref.read(cotisationDataProvider.notifier).refresh(),
                    child: ListView.builder(
                      itemCount: cotis.length,
                      itemBuilder: (context, index) {
                        final item = cotis[index];

                        return CotisationCard(item: item);
                      },
                    ),
                  ),
                );
              },
              error: (error, _) => Center(
                child: AppText(label: "Erreur: $error", color: AppColor.red),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(color: AppColor.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
