import 'package:fitness_app/presentation/screens/active_workout_screen.dart';
import 'package:fitness_app/presentation/screens/activity_screen.dart';
import 'package:fitness_app/presentation/screens/calories_screen.dart';
import 'package:fitness_app/presentation/screens/home_screen.dart';
import 'package:fitness_app/presentation/screens/profile_screen.dart';
import 'package:fitness_app/presentation/widgets/main_shell.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) => MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.activity.routeName, builder: (ctx, state) => const ActivityScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.calories.routeName, builder: (ctx, state) => const CaloriesScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.profile.routeName, builder: (ctx, state) => const ProfileScreen()),
          ],
        ),
      ],
    ),
    GoRoute(path: NamedRoutes.activeWorkout.routeName, builder: (ctx, state) => const ActiveWorkoutScreen()),
  ],
);

enum NamedRoutes {
  home('/home'),
  activity('/activity'),
  calories('/calories'),
  profile('/profile'),
  activeWorkout('/active-workout');

  final String routeName;
  const NamedRoutes(this.routeName);
}
