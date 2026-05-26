import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/providers/flutter_secure_storage_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_login_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_register_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/info_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/pages/cotisation_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/pages/event_detail_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/pages/event_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/pages/member_detail_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/pages/member_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/pages/obligation_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteKeys.loginUrl,
    routes: [
      GoRoute(
        path: RouteKeys.loginUrl,
        name: RouteKeys.loginName,
        builder: (context, state) => const AuthLoginPage(),
      ),
      GoRoute(
        path: RouteKeys.inscriptionUrl,
        name: RouteKeys.inscriptionName,
        builder: (context, state) => const AuthRegisterPage(),
      ),
      GoRoute(
        path: RouteKeys.memberDetailUrl,
        name: RouteKeys.memberDetailName,
        builder: (context, state) {
          final memberId = state.extra as int;
          return MemberDetailPage(memberId: memberId);
        },
      ),
      GoRoute(
        path: RouteKeys.obligationUrl,
        name: RouteKeys.obligationName,
        builder: (context, state) => const ObligationPage(),
      ),
      GoRoute(
        path: RouteKeys.eventDetailUrl,
        name: RouteKeys.eventDetailName,
        builder: (context, state) {
          final eventId = state.extra as int;
          return EventDetailPage(eventId: eventId);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            backgroundColor: AppColor.scaffoldBackground,
            appBar: AppBar(
              title: AppText(
                label: "Home",
                fontWeight: FontWeight.w600,
                color: AppColor.blue,
              ),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              ],
            ),
            drawer: Drawer(
              backgroundColor: AppColor.scaffoldBackground,
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Consumer(
                      builder: (context, ref, child) {
                        final info = ref.watch(infoProvider);

                        final initialName = info.fullName.isNotEmpty
                            ? info.fullName
                                  .trim()
                                  .split(" ")
                                  .take(2)
                                  .map((e) => e[0])
                                  .join()
                            : "NA";

                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 24.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColor.blue, AppColor.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24.r),
                              bottomRight: Radius.circular(24.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 34.r,
                                backgroundColor: AppColor.white,
                                child: AppText(
                                  label: initialName.toUpperCase(),
                                  color: AppColor.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),

                              SizedBox(height: 12.h),

                              AppText(
                                label: info.fullName,
                                color: AppColor.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),

                              SizedBox(height: 4.h),

                              AppText(
                                label: "Bienvenue 👋",
                                color: AppColor.white.withValues(alpha: 0.8),
                                fontSize: 12.sp,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          label: "MENU",
                          color: AppColor.textDescription,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildDrawerItem(
                                icon: Icons.person_outline,
                                label: "Profile",
                                onTap: () {},
                              ),

                              _buildDrawerItem(
                                icon: Icons.account_balance_wallet_outlined,
                                label: "Obligation",
                                onTap: () =>
                                    context.pushNamed(RouteKeys.obligationName),
                              ),

                              _buildDrawerItem(
                                icon: Icons.info_outline,
                                label: "À propos",
                                onTap: () {},
                              ),

                              _buildDrawerItem(
                                icon: Icons.settings_outlined,
                                label: "Paramètre",
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Footer
                    Divider(color: Colors.grey.withValues(alpha: 0.2)),
                    _buildDrawerItem(
                      icon: Icons.logout_rounded,
                      label: "Déconnexion",
                      color: AppColor.red,
                      onTap: () => _logout(context: context, ref: ref),
                    ),
                  ],
                ),
              ),
            ),
            body: navigationShell,
            bottomNavigationBar: Container(
              color: AppColor.white,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: GNav(
                    gap: 8,
                    color: AppColor.textDescription,
                    activeColor: AppColor.blue,
                    tabBackgroundColor: AppColor.blue.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    selectedIndex: navigationShell.currentIndex,
                    onTabChange: (index) => navigationShell.goBranch(index),
                    tabs: const [
                      GButton(icon: Icons.home_outlined, text: 'Home'),
                      GButton(icon: Icons.people_outline, text: 'Member'),
                      GButton(
                        icon: Icons.account_balance_wallet_outlined,
                        text: 'Cotisation',
                      ),
                      GButton(icon: Icons.event_outlined, text: 'Événement'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteKeys.homeUrl,
                name: RouteKeys.homeName,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteKeys.memberUrl,
                name: RouteKeys.memberName,
                builder: (context, state) => const MemberPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cotisation',
                name: 'cotisation',
                builder: (context, state) => CotisationPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/event',
                name: 'event',
                builder: (context, state) => const EventPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

Widget _buildDrawerItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color? color,
}) {
  final finalColor = color ?? AppColor.black;
  return ListTile(
    leading: Icon(icon, color: finalColor, size: 22.sp),
    title: AppText(
      label: label,
      color: finalColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    onTap: onTap,
  );
}

Future<void> _logout({required Ref ref, required BuildContext context}) async {
  final storage = ref.read(secureStorageProvider);

  await storage.deleteAll();

  if (context.mounted) {
    context.goNamed(RouteKeys.loginName);
  }
}
