import 'package:greem/providers/auth_providers.dart';
import 'package:greem/providers/data_provider.dart';
import 'package:riverpod/riverpod.dart';

import '../models/conversations.dart';

class ConversationsDataController
    extends StateNotifier<AsyncValue<List<Conversation?>>> {
  Ref ref;

  ConversationsDataController({required this.ref})
      : super(const AsyncData<List<Conversation?>>([])) {
    getConversations();
  }

  Future<List<Conversation?>?> getConversations() async {
    state = const AsyncLoading();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        final response = await ref.read(dataRepositoryProvider).conversations;

        return response;
      },
    );
  }
}


