import 'package:flutter/material.dart';

String uri = 'http://<yourip>:3000';

class GlobalVariables {

  static const BASE_URI = 'http://192.168.16.100:3001';
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

  static const image = 'https://th.bing.com/th/id/R.de48bbefa2648cef167d08f1c22d4b07?rik=AGpvVD2GYtPmbw&riu=http%3a%2f%2fmappery.com%2fmaps%2fKathmandu-City-Tourist-Map.jpg&ehk=FHYqdOMnDUlQXqsNQjyuvQ4SlmalOsdbec17Jw%2f2AVY%3d&risl=&pid=ImgRaw&r=0';

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://th.bing.com/th/id/OIP.B6_agOaV4xNBom3ouVoSggHaE7?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/R.8a279e60939ce87c476341ed8ab8d62a?rik=AMKOJa1l3RB2yw&riu=http%3a%2f%2fwww.pattayaunlimited.com%2fwp-content%2fuploads%2f2009%2f08%2fpattaya-motorcycle-hire.jpg&ehk=F1lVlXYATZddO%2fBEkz6RvO%2fpIh9Wp6l9O4xnBvmiO5Q%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.318bcde38de3e0472d7bddf4e450ce1f?rik=EpkBnNi3KR3WhA&pid=ImgRaw&r=0',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
