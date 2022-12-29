import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/providers/data_provider.dart';

import '../models/conversations.dart';
import '../models/token.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationsDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Conversation')),
      body: SafeArea(
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
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey,
                                          ),
                                          title: Text(conversation.id),
                                          subtitle: Text(
                                              'Dolor esse voluptate eu nulla.'),
                                          trailing: Text(
                                            '2 days ago',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      );
                                    })));
                          },
                          error: (error, stackTrace) {
                            return Text(error.toString());
                          },
                          loading: () => Center(
                                child: CircularProgressIndicator(),
                              ))
                    ],
                  )))),
    );
  }
}

class ConversationsScreen extends StatefulWidget {
  ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
