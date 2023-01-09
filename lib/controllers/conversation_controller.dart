import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/models/message.dart';
import 'package:greem/providers/web_socket_provider.dart';

import '../models/conversation.dart';
import '../providers/data_provider.dart';
import '../widgets/message_bubble.dart';

class ConversationDataController extends StateNotifier<AsyncValue<void>> {
  Ref ref;
  Conversation? conversation;
  String? body;
  TextEditingController bodyTextController = TextEditingController();

  ConversationDataController({required this.ref})
      : super(const AsyncData<void>(null)) {
    getConversation(ref.watch(conversationIDprovider));
  }

  Future<void> sendMessage() async {
    state = await AsyncValue.guard(
      () async {
        bodyTextController.clear();
        final response = await ref
            .read(dataRepositoryProvider)
            .sendMessage(body ?? '', conversation?.id ?? '');
        ;

        await ref.read(messageWSServiceProvider).sendMessage(response.body);
      },
    );
  }

  Future<void> getConversation(id) async {
    state = const AsyncLoading();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        var response =
            await ref.read(dataRepositoryProvider).getConversation(id);
        conversation = response;
        return;
      },
    );

    ref.watch(messageWSStreamProvider.stream).listen((event) async {
      state = await AsyncValue.guard(
        () async {
          final message =
              Message.fromJson(jsonDecode(event)["payload"]["message"]);
          message.isFromUser = conversation?.userID == message.senderID;

          message.sender = await ref
              .read(dataRepositoryProvider)
              .getUser(id: message.senderID);
          conversation?.messages.add(message);
          // alternatively I can just get a new http request of the messages
          // var response =
          //     await ref.read(dataRepositoryProvider).getConversation(id);
          // conversation = response;
        },
      );
    });
  }

  Widget buildMessageList(context, index) {
    var message = conversation?.messages[index];
    var showUsername = true;
    if (index > 1) {
      if (message?.senderID == conversation?.messages[index - 1]?.senderID) {
        showUsername = false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: MessageBubble(
        showUsername: showUsername,
        message: message!,
      ),
    );
  }
}

// Eu eu Lorem esse ullamco veniam consequat id labore ea.