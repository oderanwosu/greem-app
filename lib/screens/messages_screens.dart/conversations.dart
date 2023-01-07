import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/providers/data_provider.dart';

import '../../models/conversations.dart';
import '../../models/token.dart';

class ConversationsScreen extends ConsumerStatefulWidget {
  ConversationsScreen({Key? key}) : super(key: key);

  @override
  ConversationsScreenState createState() => ConversationsScreenState();
}

class ConversationsScreenState extends ConsumerState<ConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationsDataControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Conversation')),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.when(
                          data: (conversations) {
                            return SizedBox(
                                height: 700,
                                child: ListView.builder(
                                    itemCount: conversations.length,
                                    itemBuilder: ((context, index) {
                                      Conversation conversation =
                                          conversations[index]!;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(conversationIDprovider
                                                    .notifier)
                                                .state = conversation.id;
                                            return context.pushNamed(
                                              'conversation',
                                              params: {"id": conversation.id},
                                            );
                                          },
                                          child: ListTile(
                                            title:
                                                Text(conversation.name ?? ''),
                                            subtitle: Text(
                                              conversation
                                                      .latestMessage?.body ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            trailing: Text(
                                              conversation.latestMessage
                                                      ?.timeSentAgo ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                        ),
                                      );
                                    })));
                          },
                          error: (error, stackTrace) {
                            return Text(error.toString());
                          },
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ))
                    ],
                  )))),
    );
  }
}
