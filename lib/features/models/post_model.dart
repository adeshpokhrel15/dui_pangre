class Post {
  late String citizenshipno;
  late int phonenumber;
  late int bikeCC;
  late String bikemodel;
  late String licenceimageId;
  late String vehicledetail;
  late String bikecolor;
  late int rentprice;
  late String bikepic;

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
  });

  Post.fromJson(Map<String, dynamic> json) {
    citizenshipno = json['citizenshipno'];
    phonenumber = json['phonenumber'];
    bikeCC = json['bikeCC'];
    bikemodel = json['bikemodel'];
    licenceimageId = json['licenceimageId'];
    vehicledetail = json['vehicledetail'];
    bikecolor = json['bikecolor'];
    rentprice = json['rentprice'];
    bikepic = json['bikepic'];
  }
}
