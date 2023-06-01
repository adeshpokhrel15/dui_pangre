
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  late String id;
  late String email;
  late String userImage1;
  late String userImage2;
  late String username;
  // late String address;

  User({
    required this.id,
    required this.email,
    required this.userImage1,
    required this.userImage2,
    required this.username,
    // required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      userImage1: json['photo_1'],
      userImage2: json['photo_2'],
      username: json['username'],
      // address: json['address'],
    );
  }
}
