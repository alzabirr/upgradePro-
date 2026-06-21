import 'package:flutter/material.dart';
import '../main_shell.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/create_item_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/item_detail_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/theme_screen.dart';
import '../screens/help_screen.dart';
import '../screens/terms_screen.dart';
import '../screens/about_screen.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String shell = '/shell';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String explore = '/explore';
  static const String createItem = '/create-item';
  static const String favorites = '/favorites';
  static const String notifications = '/notifications';
  static const String itemDetail = '/item-detail';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String theme = '/theme';
  static const String help = '/help';
  static const String terms = '/terms';
  static const String settings = '/settings';
  static const String about = '/about';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return _buildRoute(const MainShell(), routeSettings);
      case shell:
        return _buildRoute(const MainShell(), routeSettings);
      case onboarding:
        return _buildRoute(const OnboardingScreen(), routeSettings);
      case login:
        return _buildRoute(const LoginScreen(), routeSettings);
      case signup:
        return _buildRoute(const SignupScreen(), routeSettings);
      case forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), routeSettings);
      case dashboard:
        return _buildRoute(const DashboardScreen(), routeSettings);
      case explore:
        return _buildRoute(const ExploreScreen(), routeSettings);
      case createItem:
        return _buildRoute(const CreateItemScreen(), routeSettings);
      case favorites:
        return _buildRoute(const FavoritesScreen(), routeSettings);
      case notifications:
        return _buildRoute(const NotificationsScreen(), routeSettings);
      case itemDetail:
        final itemId = routeSettings.arguments as String;
        return _buildRoute(ItemDetailScreen(itemId: itemId), routeSettings);
      case profile:
        return _buildRoute(const ProfileScreen(), routeSettings);
      case editProfile:
        return _buildRoute(const EditProfileScreen(), routeSettings);
      case theme:
        return _buildRoute(const ThemeScreen(), routeSettings);
      case help:
        return _buildRoute(const HelpScreen(), routeSettings);
      case terms:
        return _buildRoute(const TermsScreen(), routeSettings);
      case settings:
        return _buildRoute(const SettingsScreen(), routeSettings);
      case about:
        return _buildRoute(const AboutScreen(), routeSettings);
      default:
        return _buildRoute(const MainShell(), routeSettings);
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings routeSettings) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
