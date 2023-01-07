import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/conversations.dart';
import '../providers/data_provider.dart';

class ConversationDataController extends StateNotifier<AsyncValue<void>> {
  Ref ref;
  Conversation? conversation;
  String? body;

  ConversationDataController({required this.ref})
      : super(const AsyncData<void>(null)) {
    getConversation(ref.watch(conversationIDprovider));
  }

  Future<void> sendMessage() async {
    state = await AsyncValue.guard(
      () async {
        final response = await ref
            .read(dataRepositoryProvider)
            .sendMessage(body ?? '', conversation?.id ?? '');
      },
    );
  }

  Future<void> getConversation(id) async {
    state = const AsyncLoading();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        final response =
            await ref.read(dataRepositoryProvider).getConversation(id);
        conversation = response;
      },
    );
  }
}
