import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/user_model_data_source.dart';
import '../../../models/vehicle_items_model.dart';
import '../../../providers/post_provider.dart';
import '../managers/color_palette_manager.dart';
import '../widgets/drawer_widgets.dart';
import '../widgets/search_bar_widgets.dart';
import '../widgets/top_category_widgets.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> vehicleTypes = [
    'Bike',
    'Scoty',
    'Electric Scooter',
    'Electric Bike',
  ];
  final List<VehicleItem> bikeList = [
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/642x336/n/cw/ec/49720/tvs-apache-rr-310-right-side13.jpeg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Pulsar'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://imgd.aeplcdn.com/1280x720/n/cw/ec/53743/right-side-view.jpeg?q=100',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Jawa'),
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/642x336/n/cw/ec/49720/tvs-apache-rr-310-right-side13.jpeg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Pulsar'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://imgd.aeplcdn.com/1280x720/n/cw/ec/53743/right-side-view.jpeg?q=100',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Jawa'),
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/642x336/n/cw/ec/49720/tvs-apache-rr-310-right-side13.jpeg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Pulsar'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://imgd.aeplcdn.com/1280x720/n/cw/ec/53743/right-side-view.jpeg?q=100',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Jawa'),
  ];
  final List<VehicleItem> scooterList = [
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/370x208/bw/models/bajaj-urbanite-chetak-standard20191016163349.jpg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Scooter'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://image.made-in-china.com/2f0j00AWfYRqQcYCki/Original-Kaabo-Wolf-Warrior-11-Fast-Speed-off-Road-All-Terrain-Electric-Scooter-60V-35ah.jpg',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Vespa'),
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/370x208/bw/models/bajaj-urbanite-chetak-standard20191016163349.jpg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Scooter'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://image.made-in-china.com/2f0j00AWfYRqQcYCki/Original-Kaabo-Wolf-Warrior-11-Fast-Speed-off-Road-All-Terrain-Electric-Scooter-60V-35ah.jpg',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Vespa'),
  ];
  final List<VehicleItem> bestForYou = [
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/370x208/bw/models/bajaj-urbanite-chetak-standard20191016163349.jpg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Scooter'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://image.made-in-china.com/2f0j00AWfYRqQcYCki/Original-Kaabo-Wolf-Warrior-11-Fast-Speed-off-Road-All-Terrain-Electric-Scooter-60V-35ah.jpg',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Vespa'),
    VehicleItem(
        rating: 4.5,
        itemImg:
            'https://imgd.aeplcdn.com/642x336/n/cw/ec/49720/tvs-apache-rr-310-right-side13.jpeg?q=75',
        price: 2500,
        subtitle: 'Great Bike',
        title: 'Pulsar'),
    VehicleItem(
        rating: 4.2,
        itemImg:
            'https://imgd.aeplcdn.com/1280x720/n/cw/ec/53743/right-side-view.jpeg?q=100',
        price: 3114,
        subtitle: 'Great Bike',
        title: 'Jawa'),
  ];
  String selectedItem = 'Bike';
  int counter = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(userProvider);
      final poststream = ref.watch(postStream);
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 187, 182, 182),
            elevation: 0,
          ),
          drawer: DrawerWidgets(),
          backgroundColor: ColorPalette().scaffoldBg,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => DrawerWidgets()));
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(7.0),
                      //     height: 42.0,
                      //     width: 42.0,
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFF1F242C),
                      //       borderRadius: BorderRadius.circular(12.0),
                      //     ),
                      //     child: const Icon(Icons.person,
                      //         size: 12.0, color: Color(0xFF4D4F52)),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                  width: (MediaQuery.of(context).size.width / 3) * 2 + 25.0,
                  child: Text('Rent the Vehicle for you...',
                      style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 40.0)),
                ),
                const SizedBox(height: 20.0),
                const SearchBar(),
                const SizedBox(height: 20.0),
                const TopCategorySection(),
                SizedBox(
                    height: (MediaQuery.of(context).size.height / 2) - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: const EdgeInsets.only(top: 5.0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0),
                          child: Text(
                            'Bikes',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: 225.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...bikeList.map((e) {
                                  return _buildVehicleItem(e);
                                }).toList()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0),
                          child: Text(
                            'Scooters',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width - 10.0,
                            height: 225.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...scooterList.map((e) {
                                  return _buildVehicleItem(e);
                                }).toList()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0),
                          child: Text(
                            'Special for you',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width - 10.0,
                            height: 225.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...bestForYou.map((e) {
                                  return _buildVehicleItem(e);
                                }).toList()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildVehicleItem(VehicleItem vItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ItemDetails(vItem: vItem)));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    ColorPalette().gradientTopLeft,
                    Colors.black
                  ])),
          height: 220.0,
          width: 150.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140.0,
                width: 150.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Hero(
                        tag: vItem.itemImg.toString(),
                        child: Container(
                          height: 130.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(vItem.itemImg!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 10.0,
                        top: 10.0,
                        child: Container(
                          height: 25.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: const Color(0xFF342520).withOpacity(0.7),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: ColorPalette().coffeeSelected,
                                  size: 15.0,
                                ),
                                Text(
                                  vItem.rating.toString(),
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13.0),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  vItem.title!,
                  style: GoogleFonts.sourceSansPro(
                      color: Colors.white, fontSize: 17.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text(
                  vItem.subtitle!,
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                      fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 60.0,
                      child: Row(
                        children: [
                          Text(
                            '',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette().coffeeSelected,
                                fontSize: 20.0),
                          ),
                          Text(
                            vItem.price.toString(),
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //To Do
                      },
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                            color: ColorPalette().coffeeSelected,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 11.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypes(wheel, counter) {
    return Padding(
      padding: counter != 0
          ? const EdgeInsets.only(left: 25.0)
          : const EdgeInsets.only(left: 7.0),
      child: Container(
        height: 50.0,
        color: const Color(0xFF0D0F14),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = wheel;
                });
              },
              child: Text(
                wheel,
                style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    color: wheel == selectedItem
                        ? ColorPalette().coffeeSelected
                        : ColorPalette().coffeeUnselected,
                    fontSize: 17.0),
              ),
            ),
            const SizedBox(height: 4.0),
            Container(
              height: 8.0,
              width: 8.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: wheel == selectedItem
                      ? ColorPalette().coffeeSelected
                      : Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
