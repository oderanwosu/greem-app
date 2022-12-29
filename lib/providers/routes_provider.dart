import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/models/token.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/screens/auth.dart';
import 'package:greem/screens/home.dart';
import 'package:greem/screens/login.dart';
import 'package:riverpod/riverpod.dart';

import '../controllers/routes_controller.dart';

final routerProvider = Provider<RouterController>((ref) {
  return RouterController(ref: ref);
});

final routeRefreshProvider =
    ChangeNotifierProvider<MyNotifier>((ref) => MyNotifier());

class MyNotifier with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
