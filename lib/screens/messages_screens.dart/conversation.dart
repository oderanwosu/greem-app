import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/message_bubble.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  ConversationScreen({Key? key}) : super(key: key);

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends ConsumerState<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('_username')), body: MessageList());
  }
}

class MessageList extends ConsumerStatefulWidget {
  MessageList({Key? key}) : super(key: key);

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends ConsumerState<MessageList> {
    _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
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
                delegate: SliverChildBuilderDelegate(childCount: 10,
                    ((context, index) {
              return MessageBubble(text: 'hey whats up?', isCurrentUser: true);
            }))),
          ],
        ),
        bottomNavigationBar: _buildMessageComposer(),
      ),
    );
  }
}