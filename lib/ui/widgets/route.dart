import 'package:flutter_application_2/ui/screens/home_Screen.dart';
import 'package:flutter_application_2/ui/screens/splash_screen1.dart';
import 'package:flutter_application_2/ui/screens/splash_screen2.dart';
import 'package:flutter_application_2/ui/screens/splash_screen3.dart';
import 'package:flutter_application_2/ui/screens/splash_screen4.dart';
import 'package:flutter_application_2/ui/widgets/recipe_card.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = "/home";
  static const String news = "electronicgadgetsscreen"; // Nomi to'g'irlandi
  static const String settings = "settings";
  static const String profileSettings = "profileSettings";
  static const String notificationsSettings = "notificationsSettings";
  static const String homescreen = "homescreen";
  static const String recipe_card = "recipe_card";

  static final config = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: home,
        builder: (context, state) => const Splash1Screen(),
        routes: [
          GoRoute(
            path: news,
            name: news,
            builder: (context, state) => Splash2Screen(),
          ),
          GoRoute(
            path: profileSettings,
            name: profileSettings,
            builder: (context, state) => SplashScreen3(),
          ),
          GoRoute(
            path: notificationsSettings,
            name: notificationsSettings,
            builder: (context, state) => Splash4Screen(),
          ),
          GoRoute(
            path: homescreen,
            name: homescreen,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: recipe_card,
            name: recipe_card,
            builder: (context, state) => RecipeCard(),
          ),
        ],
      ),
    ],
  );
}
