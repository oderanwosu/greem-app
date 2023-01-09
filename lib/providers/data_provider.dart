import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/controllers/conversations_controller.dart';
import 'package:greem/models/friends.dart';
import 'package:greem/repository/data_repo.dart';

import '../controllers/conversation_controller.dart';
import '../controllers/friends_controller.dart';
import '../models/conversation.dart';
import 'auth_providers.dart';

final dataRepositoryProvider = Provider<UserDataRepository>((ref) {
  // return a concrete implementation of AuthRepository
  return UserDataRepository(tokens: ref.watch(tokensProvider), ref: ref);
});

final conversationsDataControllerProvider = StateNotifierProvider<
    ConversationsDataController, AsyncValue<List<Conversation?>>>((ref) {
  return ConversationsDataController(ref: ref);
});

final conversationDataControllerProvider = StateNotifierProvider.autoDispose<
    ConversationDataController, AsyncValue<void>>((ref) {
  return ConversationDataController(ref: ref);
});
final conversationIDprovider = StateProvider<String>(((ref) => ''));

final friendsDataControllerProvider =
    StateNotifierProvider<FriendsDataController, AsyncValue<FriendsDataModel?>>(
        (ref) {
  return FriendsDataController(ref: ref);
});

final addingFriendsDataControllerProvider =
    StateNotifierProvider<AddingFriendsDataController, AsyncValue<void>>((ref) {
  return AddingFriendsDataController(ref: ref);
});
