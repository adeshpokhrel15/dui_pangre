import 'package:image_picker/image_picker.dart';

class CartPost {
  final String userId;
  final String citizenshipNo;
  final int phoneNumber;
  final String bikeCC;
  final String bikeModel;
  final String bikeColor;
  final String vehicleDetail;
  final int rentPrice;
  final String licenseImageId;
  final String bikePic;
  final String vehicleName;
  final String location;

  CartPost({
    required this.userId,
    required this.citizenshipNo,
    required this.phoneNumber,
    required this.bikeCC,
    required this.bikeModel,
    required this.bikeColor,
    required this.vehicleDetail,
    required this.rentPrice,
    required this.licenseImageId,
    required this.bikePic,
    required this.vehicleName,
    required this.location,
  });
}
