import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/src/core/screen/auth/signin/signin.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/full_rank/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Map/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Profile/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Profile/settings_aqi/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Profile/settings_language/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/dashboard_page.dart';
import 'package:pollusafe_app/src/core/screen/splash_screen/splash_screen.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/splashscreen';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/splashscreen',
        name: 'splashscreen',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (context, state) => const Signin(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: 'home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'map',
            name: 'map',
            builder: (context, state) => const MapPage(),
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'fullrank',
            name: 'fullrank',
            builder: (context, state) => const FullRank(),
          ),
          GoRoute(
            path: 'settingsaqi',
            name: 'settings_aqi',
            builder: (context, state) => SettingsAqi(),
          ),
          GoRoute(
            path: 'settingslanguage',
            name: 'settings_language',
            builder: (context, state) => SettingsLanguage(),
          ),
        ],
      ),
    ],
  );
}
