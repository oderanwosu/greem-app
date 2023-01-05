class AppUser {
  String username;
  String? lname;
  String? fname;
  String? email;
  String? avatarURL;
  String id;
  String? greem;
  List? friends;

  List? conversations;
  List<dynamic>? friendRequest;
  int? createdAt;

  AppUser(
      {required this.id,
      required this.email,
      required this.username,
      this.avatarURL,
      this.fname,
      this.lname,
      this.greem,
      this.friends,
      this.conversations,
      this.createdAt,
      this.friendRequest});
  factory AppUser.fromJson(json) {
    return AppUser(
        fname: json['fname'],
        avatarURL: json['avatar'],
        lname: json['lname'],
        username: json['username'],
        email: json['email'],
        id: json['id'],
        greem: json['greem'],
        friends: json['friends'],
        conversations: json['conversations'],
        createdAt: json['createdAt'],
        friendRequest: json['friend_requests']);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
      };
}

class AuthUser {
  String username;
  String email;
  String id;

  AuthUser({
    required this.username,
    required this.email,
    required this.id,
  });

  factory AuthUser.fromJson(json) {
    return AuthUser(
      username: json['username'],
      email: json['email'],
      id: json['id'],
    );
  }
}
