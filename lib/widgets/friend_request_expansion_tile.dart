import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          List<dynamic> friendRequest = data!.friendRequest;
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
                                    .denyFriendRequest(friendRequest[index]);
                                setState(() {
                                  friendRequest.removeAt(index);
                                });
                              },
                              key: Key(index.toString()),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                ),
                                title: Text(friendRequest[index]),
                                trailing: IconButton(
                                    onPressed: () async {
                                      ref
                                          .read(friendsDataControllerProvider
                                              .notifier)
                                          .acceptFriendRequest(
                                              friendRequest[index]);
                                      friendRequest.removeAt(index);
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
