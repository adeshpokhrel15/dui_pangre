import 'package:flutter/material.dart';

String uri = 'http://192.168.16.103:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://entrackr.com/storage/2019/05/scooter-rental-1200x600.jpg',
    'https://www.punekarnews.in/wp-content/uploads/2020/09/E-bike.jpg',
    'https://qikown.com/wp-content/uploads/2021/05/Motorbike-Rental-App-Development-1.jpg',
  ];
}
