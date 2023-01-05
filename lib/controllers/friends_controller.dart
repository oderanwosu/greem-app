import 'package:flutter/material.dart';
import 'package:greem/models/friends.dart';
import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/data_provider.dart';

class FriendsDataController
    extends StateNotifier<AsyncValue<FriendsDataModel?>> {
  Ref ref;

  FriendsDataController({required this.ref})
      : super(const AsyncData<FriendsDataModel?>(null)) {
    getData();
  }

  Future<FriendsDataModel?> getData() async {
    state = const AsyncLoading();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        final friends = await ref.read(dataRepositoryProvider).getFriends();

        final friendRequests =
            await ref.read(dataRepositoryProvider).getFriendRequests();

        FriendsDataModel data =
            FriendsDataModel(friends: friends, friendRequests: friendRequests);

        return data;
      },
    );
  }

  Future<void> acceptFriendRequest(String id) async {
    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        final response =
            await ref.read(dataRepositoryProvider).acceptFriendRequest(id);
      },
    );
  }

  Future<void> denyFriendRequest(String id) async {
    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard(
      () async {
        final response =
            await ref.read(dataRepositoryProvider).denyFriendRequest(id);
      },
    );
  }
}

class AddingFriendsDataController extends StateNotifier<AsyncValue<void>> {
  Ref ref;

  AddingFriendsDataController({required this.ref})
      : super(const AsyncData<void>(null));

  String greemCode = '';

  void showSnackBarOnError(BuildContext context) => state.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
  Future<void> addFriendAndRoute(context) async {
    state = const AsyncLoading<void>();

    // password == confirmedPassword ? ;
    // call `authRepository.signInAnonymously` and await for the result
    state = await AsyncValue.guard<void>(() async =>
        await ref.read(dataRepositoryProvider).addFriend(greemCode));
  }
}
