import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/widgets/friend_request_expansion_tile.dart';

import '../../models/conversations.dart';
import '../../providers/data_provider.dart';

class MyFriendsScreen extends ConsumerStatefulWidget {
  MyFriendsScreen({Key? key}) : super(key: key);

  @override
  MyFriendsScreenState createState() => MyFriendsScreenState();
}

class MyFriendsScreenState extends ConsumerState<MyFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendsDataControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Friends'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    context.push('/friends/add');
                  },
                  child: Text(
                    'Add Friend',
                  )),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await ref.refresh(friendsDataControllerProvider);
          },
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: state.when(
                    data: (data) {
                      var friends = data?.friends;
                      return Column(
                        children: [
                          FriendRequestExpansionTile(),
                          const Divider(),
                          SizedBox(
                              height: 700,
                              child: ListView.builder(
                                  itemCount: friends?.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(
                                              friends?[index]?.avatarURL ?? ''),
                                        ),
                                        subtitle: Text(
                                            friends?[index]?.username ?? ''),
                                        title: Text(
                                            '${friends?[index]!.fname!} ${friends?[index]!.lname!}'),
                                      ),
                                    );
                                  }))),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ))),
          ),
        ));
  }
}
