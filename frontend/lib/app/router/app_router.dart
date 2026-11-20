import 'package:frontend/app/main/main_layout.dart';
import 'package:frontend/app/router/app_routes.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => navigationShell.goBranch(index),
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) {
                final userId = state.extra as int;

                return HomeScreen(userId: userId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
