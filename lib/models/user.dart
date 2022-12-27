class AppUser {
  String username;
  String email;
  String id;
  String? greem;
  List? friends;
  List? conversations;
  DateTime? createdAt;

  AppUser({
    required this.id,
    required this.email,
    required this.username,
   this.greem,
    this.friends,
    this.conversations,
    this.createdAt,
  });
  factory AppUser.fromJson(json) {
    return AppUser(
      username: json['username'],
      email: json['email'],
      id: json['id'],
      greem: json['greem'],
      friends: json['friends'],
      conversations: json['conversations'],
      createdAt: json['createdAt'],
    );
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
