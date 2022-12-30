import 'package:go_router/go_router.dart';
import 'package:greem/screens/dashboard.dart';
import 'package:greem/screens/friends_screen.dart/add_friend.dart';
import 'package:greem/screens/friends_screen.dart/friends.dart';
import 'package:greem/screens/settings.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/auth_providers.dart';
import '../providers/routes_provider.dart';
import '../screens/auth_screens/auth.dart';
import '../screens/messages_screens.dart/conversations.dart';

class RouterController extends StateNotifier {
  Ref ref;
  final List<RouteBase> _routeRegistry = [
    ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardScreen(child: child);
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/conversations',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ConversationsScreen(),
            ),
          ),
          GoRoute(
              path: '/friends',
              pageBuilder: (context, state) => NoTransitionPage(
                    child: MyFriendsScreen(),
                  ),
              routes: [
                GoRoute(
                  path: 'add',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: AddFriendScreen(),
                  ),
                )
              ]),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ]),
    GoRoute(
      path: "/auth",
      builder: (context, state) => AuthScreen(),
    )
  ];

  RouterController({required this.ref}) : super(null);

  GoRouter get router => GoRouter(
        initialLocation: '/conversations',
        refreshListenable: ref.read(routeRefreshProvider),
        routes: _routeRegistry,
        redirect: (context, state) => routeRedirectPolicy(context, state),
      );

  String? routeRedirectPolicy(context, GoRouterState state) {
    var token = ref.read(tokensProvider).token;

    if (token != null) {
      return state.location == '/auth' ? '/conversations' : null;
    }

    var authRoutePath = "/auth";
    // ref.watch(eventStoreProvider).bus.fire(Navigated(loginRoutePath));
    return authRoutePath;
  }
}
