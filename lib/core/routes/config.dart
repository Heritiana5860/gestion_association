import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_login_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_register_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/pages/member_detail_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/pages/member_page.dart';

final router = GoRouter(
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

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => Scaffold(
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
        drawer: Drawer(),
        body: navigationShell,
        bottomNavigationBar: Container(
          color: AppColor.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      ),
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
              builder: (context, state) => Container(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/event',
              name: 'event',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
