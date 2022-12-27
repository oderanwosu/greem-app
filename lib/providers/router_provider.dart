import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/models/token.dart';
import 'package:greem/providers/providers.dart';
import 'package:greem/screens/auth.dart';
import 'package:greem/screens/home.dart';
import 'package:greem/screens/login.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider<RouterController>((ref) {
  return RouterController(ref: ref);
});

// class RouterNotifier extends ChangeNotifier {
//   final Ref _ref;

//   RouterNotifier(this._ref) {}

//   String? _redirectLogic(GoRouterState state) {
//     final loginState = _ref.read(loginScreenControllerProvider);
//     final isLoggedIn = state.location == 'auth';
//     if (loginState.value) {
//       return isLoggedIn ? null : '/auth';
//     }

//     if (isLoggedIn) return '/';
//     return null;
//   }

//   List<GoRoute> get _routes => [
//         GoRoute(
//           name: 'authentication',
//           builder: (context, state) => AuthScreen(),
//           path: 'auth',
//         ),
//         GoRoute(
//           name: 'home',
//           builder: (context, state) => HomeScreen(),
//           path: '/',
//         )
//       ];
// }

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

final routeRefreshProvider =
    ChangeNotifierProvider<MyNotifier>((ref) => MyNotifier());

class MyNotifier with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
