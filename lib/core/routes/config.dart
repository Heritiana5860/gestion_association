import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_login_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/pages/auth_register_page.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/pages/home_page.dart';
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: AppColor.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Member',
              backgroundColor: AppColor.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Cotisation',
              backgroundColor: AppColor.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Evénement',
              backgroundColor: AppColor.white,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColor.textDescription,
          selectedItemColor: AppColor.blue,
          currentIndex: navigationShell.currentIndex,
          onTap: (value) => navigationShell.goBranch(value),
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
