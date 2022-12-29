import 'package:greem/providers/auth_providers.dart';
import 'package:riverpod/riverpod.dart';

import '../models/token.dart';
import '../providers/routes_provider.dart';
import '../repository/auth_repo.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  // set the initial value
  Ref ref;
  AuthController({required this.authRepository, required this.ref})
      : super(const AsyncData<void>(null));

  final AuthRepository authRepository;
  String? email;
  String? username;
  String? password;
  String? confirmPassword;

  Future<void> register() async {
    // set the state to loading
    state = const AsyncLoading<void>();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard<void>(
      () async {
        if (!(password == confirmPassword)) throw 'Passwords do not match';

        final response = await authRepository.registerUser(
            email: email, username: username, password: password);
        await login();
      },
    );
  }

  Future<void> login() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(() async {
      Tokens? tokens =
          await authRepository.loginUser(email: email!, password: password!);

      ref.read(tokensProvider).token = tokens!.refreshToken;
      ref.read(tokensProvider).refreshToken = tokens.token;

      // ref.read(myNotifierProvider);
    });
    ref.read(routeRefreshProvider).refresh();
  }

  Future<void> logout() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(() async {
      await ref.read(tokensProvider).deleteLocalTokens();
    });
    ref.read(routeRefreshProvider).refresh();
  }
}
