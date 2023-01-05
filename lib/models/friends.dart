import 'package:greem/models/user.dart';

class FriendsDataModel {
  List<AppUser?> friends;
  List<AppUser?> friendRequests;

  FriendsDataModel({required this.friends, required this.friendRequests});
}
