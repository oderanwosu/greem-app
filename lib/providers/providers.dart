import 'package:flutter/material.dart';
import 'package:greem/controllers/auth_controller.dart';
import 'package:greem/controllers/login_controller.dart';
import 'package:greem/models/token.dart';
import 'package:greem/models/user.dart';
import 'package:greem/repository/data_repo.dart';
import 'package:greem/screens/login.dart';
import 'package:riverpod/riverpod.dart';

import '../controllers/register_controller.dart';
import '../repository/auth_repo.dart';

final tokensProvider = StateProvider<Tokens>((ref) {
  return Tokens();
});
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // return a concrete implementation of AuthRepository
  return AuthRepository(tokens: ref.watch(tokensProvider));
});

final UserDataRepositoryProvider = Provider<UserDataRepository>((ref) {
  // return a concrete implementation of AuthRepository
  return UserDataRepository(tokens: ref.watch(tokensProvider));
});

final targetUserProvider = Provider<String>((ref) {
  return '';
});

final userProvider = FutureProvider<AppUser?>((ref) {
  return ref
      .read(UserDataRepositoryProvider)
      .getUser(ref.read(targetUserProvider));
});

// final registerScreenControllerProvider = // StateNotifierProvider takes the controller class and state class as type arguments
//     StateNotifierProvider.autoDispose<RegisterScreenController,
//         AsyncValue<void>>((ref) {
//   return RegisterScreenController(
//     authRepository: ref.watch(authRepositoryProvider),
//   );
// });

final authScreenControllerProvider =
    StateNotifierProvider.autoDispose<AuthScreenController, AsyncValue<void>>(
        (ref) {
  return AuthScreenController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref);
});

final authStateProvider = StreamProvider<Tokens?>((ref) {
  return ref.watch(tokensProvider).getlocalTokenStream();
});

final inAppStateProvider = StateProvider<Function>((ref) {
  return () {};
});
