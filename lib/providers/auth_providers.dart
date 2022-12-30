import 'package:flutter/material.dart';
import 'package:greem/controllers/auth_controller.dart';

import 'package:greem/models/token.dart';
import 'package:greem/models/user.dart';
import 'package:greem/repository/data_repo.dart';
import 'package:greem/screens/auth_screens/login.dart';
import 'package:riverpod/riverpod.dart';

import '../controllers/auth_controller.dart';
import '../repository/auth_repo.dart';

final tokensProvider = StateProvider<Tokens>((ref) {
  return Tokens();
});
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // return a concrete implementation of AuthRepository
  return AuthRepository(tokens: ref.watch(tokensProvider), ref: ref);
});

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) {
  return AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref);
});

final appInitializationProvider = StreamProvider<Tokens?>((ref) {
  return ref.watch(tokensProvider).getlocalTokenStream();
});
