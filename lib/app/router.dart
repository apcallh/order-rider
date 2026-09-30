import 'package:go_router/go_router.dart';
import 'package:order_rider/presentation/screens/splash_screen.dart';
import 'package:order_rider/presentation/screens/onboarding_screen.dart';
import 'package:order_rider/presentation/screens/auth/login_screen.dart';
import 'package:order_rider/presentation/screens/auth/register_screen.dart';
import 'package:order_rider/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:order_rider/presentation/screens/map/map_screen.dart';
import 'package:order_rider/presentation/screens/orders/orders_screen.dart';
import 'package:order_rider/presentation/screens/sessions/sessions_screen.dart';
import 'package:order_rider/presentation/screens/analytics/analytics_screen.dart';
import 'package:order_rider/presentation/screens/profile/profile_screen.dart';
import 'package:order_rider/presentation/screens/settings/settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (c, s) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/register', builder: (c, s) => const RegisterScreen()),
      GoRoute(path: '/dashboard', builder: (c, s) => const DashboardScreen()),
      GoRoute(path: '/map', builder: (c, s) => const MapScreen()),
      GoRoute(path: '/orders', builder: (c, s) => const OrdersScreen()),
      GoRoute(path: '/sessions', builder: (c, s) => const SessionsScreen()),
      GoRoute(path: '/analytics', builder: (c, s) => const AnalyticsScreen()),
      GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
      GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
    ],
  );
}
