class User {
  late String email;
  late String userImage;
  late String username;
  late String address;

  User({
    required this.email,
    required this.userImage,
    required this.username,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userImage: json['userImage'],
      username: json['username'],
      address: json['address'],
    );
  }
}
