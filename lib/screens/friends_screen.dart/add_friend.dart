import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/providers/data_provider.dart';

class AddFriendScreen extends ConsumerStatefulWidget {
  AddFriendScreen({Key? key}) : super(key: key);

  @override
  AddFriendScreenState createState() => AddFriendScreenState();
}

class AddFriendScreenState extends ConsumerState<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> _state =
        ref.watch(addingFriendsDataControllerProvider);

    ref.listen<AsyncValue<void>>(
      addingFriendsDataControllerProvider,
      (_, state) => ref
          .read(addingFriendsDataControllerProvider.notifier)
          .showSnackBarOnError(context),
    );

    return !_state.isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Add Friend'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // The width will be 100% of the parent widget
                      // The height will be 60
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () async {
                    await ref
                        .read(addingFriendsDataControllerProvider.notifier)
                        .addFriendAndRoute(context);
                  },
                  child: const Text('Add Friend')),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter Greem Code',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onChanged: (val) {
                            ref
                                .read(addingFriendsDataControllerProvider
                                    .notifier)
                                .greemCode = val;
                          },

                          // initialValue:
                          //     ref.read(authControllerProvider.notifier).password,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Greem code'),
                        ),
                      ]),
                ),
              ),
            ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
