import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/auth_providers.dart';
import '../providers/routes_provider.dart';
import '../screens/auth.dart';
import '../screens/home.dart';

class RouterController extends StateNotifier {
  Ref ref;
  final List<GoRoute> _routeRegistry = [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: "/auth",
      builder: (context, state) => AuthScreen(),
    )
  ];

  RouterController({required this.ref}) : super(null);

  GoRouter get router => GoRouter(
        refreshListenable: ref.read(routeRefreshProvider),
        routes: _routeRegistry,
        redirect: (context, state) => routeRedirectPolicy(context, state),
      );

  String? routeRedirectPolicy(context, GoRouterState state) {
    var token = ref.read(tokensProvider).token;
   

    if (token != null) {
      return state.location == '/auth' ? '/' : null;
    }

    var authRoutePath = "/auth";
    // ref.watch(eventStoreProvider).bus.fire(Navigated(loginRoutePath));
    return authRoutePath;
  }
}
