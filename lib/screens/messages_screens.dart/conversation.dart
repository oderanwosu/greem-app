import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/providers/data_provider.dart';

import '../../models/message.dart';
import '../../widgets/message_bubble.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  String id;
  ConversationScreen({required this.id});

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends ConsumerState<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(conversationDataControllerProvider);

    return !state.isLoading
        ? Scaffold(
            appBar: AppBar(
                title: Text(ref
                        .watch(conversationDataControllerProvider.notifier)
                        .conversation
                        ?.name ??
                    'Messages')),
            body: MessageList(
                messages: ref
                        .watch(conversationDataControllerProvider.notifier)
                        .conversation
                        ?.messages ??
                    []))
        : Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );

    // state.when(
    //     skipLoadingOnReload: true,
    //     data: (conversation) {
    //       return Scaffold(
    //           appBar: AppBar(title: Text(conversation?.name ?? 'Messages')),
    //           body: MessageList(messages: conversation?.messages ?? []));
    //     },
    //     loading: () => Scaffold(
    //           body: const Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //     error: ((error, stackTrace) => Scaffold(
    //           body: Text(error.toString()),
    //         )));
  }
}

class MessageList extends ConsumerStatefulWidget {
  final List<Message?> messages;

  MessageList({required this.messages});

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends ConsumerState<MessageList> {
  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                ref.watch(conversationDataControllerProvider.notifier).body =
                    value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              await ref
                  .watch(conversationDataControllerProvider.notifier)
                  .sendMessage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: widget.messages.length, ((context, index) {
              var message = widget.messages[index];

              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: MessageBubble(
                    username: message?.sender?.username ?? '',
                    text: message?.body ?? '',
                    isCurrentUser: message?.isFromUser ?? false),
              );
            }))),
          ],
        ),
        bottomNavigationBar: _buildMessageComposer(),
      ),
    );
  }
}
