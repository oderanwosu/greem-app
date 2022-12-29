import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/controllers/conversation_controller.dart';
import 'package:greem/repository/data_repo.dart';

import '../models/conversations.dart';
import 'auth_providers.dart';

final dataRepositoryProvider = Provider<UserDataRepository>((ref) {
  // return a concrete implementation of AuthRepository
  return UserDataRepository(tokens: ref.watch(tokensProvider), ref: ref);
});

final conversationsDataProvider = StateNotifierProvider<
    ConversationsDataController, AsyncValue<List<Conversation?>>>((ref) {
  return ConversationsDataController(ref: ref);
});
