import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/models/token.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/providers/data_provider.dart';
import 'package:greem/screens/auth_screens/auth.dart';
import 'package:greem/screens/messages_screens.dart/conversations.dart';
import 'package:greem/screens/auth_screens/login.dart';
import 'package:riverpod/riverpod.dart';

import '../controllers/routes_controller.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<RouterController>((ref) {
  return RouterController(ref: ref);
});

final routeRefreshProvider =
    ChangeNotifierProvider<MyNotifier>((ref) => MyNotifier(ref));

class MyNotifier with ChangeNotifier {
  Ref ref;
  MyNotifier(this.ref);
  void refresh() {
    notifyListeners();
  }
}
