class User {
  late String email;
  late String userImage1;
  late String userImage2;
  late String username;
  late String address;

  User({
    required this.email,
    required this.userImage1,
    required this.userImage2,
    required this.username,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userImage1: json['userImage1'],
      userImage2: json['userImage2'],
      username: json['username'],
      address: json['address'],
    );
  }
}
