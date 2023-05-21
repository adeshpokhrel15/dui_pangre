import 'dart:convert';

// List<Post> postsFromJson(String str)=> List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
Post postFromJson(String str) => Post.fromJson(json.decode(str));

class Post {
  late String id;
  late String citizenshipno;
  late int phonenumber;
  late String bikeCC;
  late String bikemodel;
  late String licenceimageId;
  late String vehicledetail;
  late String bikecolor;
  late int rentprice;
  late String bikepic;
  late String userId;
  late String vehiclename;
  late String location;
  late bool isreserved;

  Post({
    required this.citizenshipno,
    required this.phonenumber,
    required this.bikeCC,
    required this.bikemodel,
    required this.licenceimageId,
    required this.vehicledetail,
    required this.bikecolor,
    required this.rentprice,
    required this.bikepic,
    required this.id,
    required this.userId,
    required this.vehiclename,
    required this.location,
    this.isreserved = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['userId'],
      userId: json['userId'],
      vehiclename: json['vehicleName'],
      citizenshipno: json['citizenshipno'],
      phonenumber: json['phonenumber'],
      bikeCC: json['bikeCC'],
      bikemodel: json['bikemodel'],
      licenceimageId: json['licenceimageId'],
      vehicledetail: json['vehicledetail'],
      bikecolor: json['bikecolor'],
      rentprice: json['rentprice'],
      location: json['location'],
      bikepic: json['bikepic'],
    );
  }
}
