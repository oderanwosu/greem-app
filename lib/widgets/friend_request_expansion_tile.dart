import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../providers/data_provider.dart';

class FriendRequestExpansionTile extends ConsumerStatefulWidget {
  FriendRequestExpansionTile({Key? key}) : super(key: key);

  @override
  FriendRequestExpansionTileState createState() =>
      FriendRequestExpansionTileState();
}

class FriendRequestExpansionTileState
    extends ConsumerState<FriendRequestExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendsDataControllerProvider);
    return state.when(
        data: ((data) {
          List<AppUser?> friendRequest = data!.friendRequests;
          return ExpansionTile(
              title: const Text(
                "Friend Request",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: [
                SizedBox(
                    height: 400,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        addRepaintBoundaries: false,
                        itemCount: friendRequest.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              onDismissed: (direction) {
                                // Remove the item from the data source.
                                ref
                                    .read(
                                        friendsDataControllerProvider.notifier)
                                    .denyFriendRequest(
                                        friendRequest[index]!.id);
                                setState(() {
                                  friendRequest.removeAt(index);
                                });
                              },
                              key: Key(index.toString()),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      friendRequest[index]!.avatarURL!),
                                ),
                                subtitle: Text(friendRequest[index]!.username),
                                title: Text(
                                    '${friendRequest[index]!.fname!} ${friendRequest[index]!.lname!}'),
                                trailing: IconButton(
                                    onPressed: () {
                                      ref
                                          .read(friendsDataControllerProvider
                                              .notifier)
                                          .acceptFriendRequest(
                                              friendRequest[index]!.id);
                                      setState(() {
                                        friendRequest.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.add)),
                              ),
                            ),
                          );
                        }))),
              ]);
        }),
        loading: () => Container(),
        error: ((error, stackTrace) => Container()));
  }
}
