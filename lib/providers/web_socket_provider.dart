import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/models/conversation.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/providers/data_provider.dart';
import 'package:greem/services/web_socket.dart';

import '../models/message.dart';

final messageWSServiceProvider = Provider<MessageWS>((ref) {
  return MessageWS(tokens: ref.watch(tokensProvider), ref: ref);
});

StreamProvider messageWSStreamProvider = StreamProvider((ref) async* {
  ref.watch(messageWSServiceProvider).connect();
  await for (final value
  
      in ref.watch(messageWSServiceProvider).channel!.stream) {
    yield value;
  }
});

// StreamProvider<List<Message?>?> conversationStreamProvider =
//     StreamProvider<List<Message?>?>((ref) async* {
//   yield ref
//       .watch(conversationDataControllerProvider.notifier)
//       .conversation
//       ?.messages;
// });
