import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/widgets/cotisation_stats_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/banner.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/bar_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/stat_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final memberStats = ref.watch(memberDataStats);
    final cotisationStat = ref.watch(cotisationStats);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: Padding(
        padding: globalPadding(),
        child: SingleChildScrollView(
          child: ListAnimated(
            children: [
              AppText(
                label: "Salut Beto!",
                fontSize: 16.sp,
                color: AppColor.blue,
                fontWeight: FontWeight.w800,
              ),
              AppText(
                label: "On espère que tu vas bien aujourd'hui!",
                fontSize: 13.sp,
                color: AppColor.textDescription,
              ),

              SizedBox(height: 16.h),

              BannerCard(),

              SizedBox(height: 16.h),

              AppText(
                label: "Statistques",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(height: 10.h),

              SizedBox(
                child: Column(
                  spacing: 20.h,
                  children: [
                    memberStats.when(
                      data: (stats) {
                        return Column(
                          children: [
                            // Carte répartition
                            Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColor.lightGrey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        label: "Répartition des membres",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      // Donut chart
                                      SizedBox(
                                        width: 90.w,
                                        height: 90.h,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            PieChart(
                                              PieChartData(
                                                sectionsSpace: 2,
                                                centerSpaceRadius: 28.r,
                                                sections: [
                                                  PieChartSectionData(
                                                    value:
                                                        stats.doyensPourcantage,
                                                    color: Colors.orange,
                                                    radius: 18.r,
                                                    showTitle: false,
                                                  ),
                                                  PieChartSectionData(
                                                    value: stats
                                                        .anciensPourcentage,
                                                    color: AppColor.blue,
                                                    radius: 18.r,
                                                    showTitle: false,
                                                  ),
                                                  PieChartSectionData(
                                                    value: stats
                                                        .novicesPourcentage,
                                                    color: AppColor.green,
                                                    radius: 18.r,
                                                    showTitle: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppText(
                                                  label: "${stats.total}",
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                AppText(
                                                  label: "membres",
                                                  fontSize: 9.sp,
                                                  color:
                                                      AppColor.textDescription,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      // Barres de pourcentage
                                      Expanded(
                                        child: Column(
                                          children: [
                                            BarRow(
                                              label: "Doyen(ne)s",
                                              pct:
                                                  stats.doyensPourcantage / 100,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(height: 8.h),
                                            BarRow(
                                              label: "Ancien(ne)s",
                                              pct:
                                                  stats.anciensPourcentage /
                                                  100,
                                              color: AppColor.blue,
                                            ),
                                            SizedBox(height: 8.h),
                                            BarRow(
                                              label: "Novices",
                                              pct:
                                                  stats.novicesPourcentage /
                                                  100,
                                              color: AppColor.green,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 4.h),

                                  Row(
                                    children: [
                                      StatCard(
                                        icon: Icons.workspace_premium_rounded,
                                        value: "${stats.doyens}",
                                        label: "Doyen(ne)s",
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 8.w),
                                      StatCard(
                                        icon: Icons.star_rounded,
                                        value: "${stats.anciens}",
                                        label: "Ancien(ne)s",
                                        color: AppColor.blue,
                                      ),
                                      SizedBox(width: 8.w),
                                      StatCard(
                                        icon: Icons.auto_awesome,
                                        value: "${stats.novices}",
                                        label: "Novices",
                                        color: AppColor.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (e, _) => Center(
                        child: AppText(
                          label: "Erreur serveur.",
                          color: AppColor.red,
                        ),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),

                    cotisationStat.when(
                      data: (stat) {
                        return CotisationStatsCard(stat: stat);
                      },
                      error: (error, _) => Center(
                        child: AppText(
                          label: "Erreur: $error",
                          color: AppColor.red,
                        ),
                      ),
                      loading: () => Center(
                        child: CircularProgressIndicator(color: AppColor.blue),
                      ),
                    ),
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
