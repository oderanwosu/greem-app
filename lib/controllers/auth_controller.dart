import 'package:greem/models/user.dart';
import 'package:riverpod/riverpod.dart';

import '../models/token.dart';
import '../repository/data_repo.dart';

// class UserAccountScreenController extends StateNotifier<AsyncValue<void>> {
//   final UserDataRepository userDataRepository;

//   UserAccountScreenController({required this.authRepository})
//       : super(const AsyncData<void>(null));

//   Future<void> login() async {
//     state = const AsyncLoading<void>();

//     state = await AsyncValue.guard<AppUser>(() async {
//       user = userDataRepository.getUser(username)

//       authRepository.tokens = tokens;
//     });
//   }
// }
