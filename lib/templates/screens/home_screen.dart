import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_wheelers/templates/screens/item_details_screen.dart';

import '../../../providers/post_provider.dart';
import '../managers/color_palette_manager.dart';
import '../widgets/drawer_widgets.dart';
import '../widgets/search_bar_widgets.dart';

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
  String selectedItem = 'Bike';
  int counter = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final poststream = ref.watch(postStream);
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            elevation: 0,
          ),
          drawer: DrawerWidgets(),
          backgroundColor: Colors.white,
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
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Search for Your Dream Vehicle...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35,
                      letterSpacing: 1.5,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const SearchBar(),
                const SizedBox(height: 8.0),
                poststream.when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: (MediaQuery.of(context).size.height / 2) -
                                  -80,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                padding: const EdgeInsets.only(top: 5.0),
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 15.0, right: 15.0, top: 10.0),
                                  //   child: Text(
                                  //     'Bikes',
                                  //     style: GoogleFonts.sourceSansPro(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.black,
                                  //         fontSize: 18.0),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Container(
                                      color: Colors.transparent,
                                      width: double.infinity,
                                      height: 225.0,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ItemDetails(
                                                                vItem: data[
                                                                    index])));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: <Color>[
                                                          ColorPalette()
                                                              .gradientTopLeft,
                                                          Colors.black
                                                        ])),
                                                height: 220.0,
                                                width: 150.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                              tag: Text(data[
                                                                      index]
                                                                  .bikecolor),
                                                              child: Container(
                                                                height: 130.0,
                                                                width: 130.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(data[index].bikepic),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
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
                                                                    color: const Color(
                                                                            0xFF342520)
                                                                        .withOpacity(
                                                                            0.7),
                                                                    borderRadius: const BorderRadius
                                                                            .only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                15.0),
                                                                        bottomLeft:
                                                                            Radius.circular(15.0))),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: ColorPalette()
                                                                            .coffeeSelected,
                                                                        size:
                                                                            15.0,
                                                                      ),
                                                                      //rating number
                                                                      Text(
                                                                        '4.5',
                                                                        style: GoogleFonts.sourceSansPro(
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        data[index].bikeCC,
                                                        style: GoogleFonts
                                                            .sourceSansPro(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17.0),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              bottom: 5.0),
                                                      child: Text(
                                                        'hello',
                                                        // data[index].vehiclename,
                                                        style: GoogleFonts
                                                            .sourceSansPro(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            height: 40.0,
                                                            width: 60.0,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '',
                                                                  style: GoogleFonts.sourceSansPro(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: ColorPalette()
                                                                          .coffeeSelected,
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                                Text(
                                                                  'Rs.${data[index].rentprice.toString()}',
                                                                  style: GoogleFonts.sourceSansPro(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20.0),
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
                                                                  color: ColorPalette()
                                                                      .coffeeSelected,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 11.0,
                                                                  color: Colors
                                                                      .white,
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    error: (err, stack) => Text("$err"),
                    loading: () => const CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget _buildVehicleItem(VehicleItem vItem) {
  //   // return Padding(
  //   //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  //   //   child: GestureDetector(
  //   //     onTap: () {
  //   //       Navigator.of(context).push(MaterialPageRoute(
  //   //           builder: (context) => ItemDetails(vItem: vItem)));
  //   //     },
  //   //     child: Container(
  //   //       decoration: BoxDecoration(
  //   //           borderRadius: BorderRadius.circular(15.0),
  //   //           gradient: LinearGradient(
  //   //               begin: Alignment.topLeft,
  //   //               end: Alignment.bottomRight,
  //   //               colors: <Color>[
  //   //                 ColorPalette().gradientTopLeft,
  //   //                 Colors.black
  //   //               ])),
  //   //       height: 220.0,
  //   //       width: 150.0,
  //   //       child: Column(
  //   //         crossAxisAlignment: CrossAxisAlignment.start,
  //   //         children: [
  //   //           SizedBox(
  //   //             height: 140.0,
  //   //             width: 150.0,
  //   //             child: Stack(
  //   //               children: [
  //   //                 Positioned(
  //   //                   top: 10.0,
  //   //                   left: 10.0,
  //   //                   child: Hero(
  //   //                     tag: vItem.itemImg.toString(),
  //   //                     child: Container(
  //   //                       height: 130.0,
  //   //                       width: 130.0,
  //   //                       decoration: BoxDecoration(
  //   //                           image: DecorationImage(
  //   //                             image: NetworkImage(vItem.itemImg!),
  //   //                             fit: BoxFit.cover,
  //   //                           ),
  //   //                           borderRadius: BorderRadius.circular(15.0)),
  //   //                     ),
  //   //                   ),
  //   //                 ),
  //   //                 Positioned(
  //   //                     right: 10.0,
  //   //                     top: 10.0,
  //   //                     child: Container(
  //   //                       height: 25.0,
  //   //                       width: 50.0,
  //   //                       decoration: BoxDecoration(
  //   //                           color: const Color(0xFF342520).withOpacity(0.7),
  //   //                           borderRadius: const BorderRadius.only(
  //   //                               topRight: Radius.circular(15.0),
  //   //                               bottomLeft: Radius.circular(15.0))),
  //   //                       child: Center(
  //   //                         child: Row(
  //   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   //                           children: [
  //   //                             Icon(
  //   //                               Icons.star,
  //   //                               color: ColorPalette().coffeeSelected,
  //   //                               size: 15.0,
  //   //                             ),
  //   //                             Text(
  //   //                               vItem.rating.toString(),
  //   //                               style: GoogleFonts.sourceSansPro(
  //   //                                   fontWeight: FontWeight.bold,
  //   //                                   color: Colors.white,
  //   //                                   fontSize: 13.0),
  //   //                             )
  //   //                           ],
  //   //                         ),
  //   //                       ),
  //   //                     ))
  //   //               ],
  //   //             ),
  //   //           ),
  //   //           Padding(
  //   //             padding: const EdgeInsets.only(left: 10.0),
  //   //             child: Text(
  //   //               vItem.title!,
  //   //               style: GoogleFonts.sourceSansPro(
  //   //                   color: Colors.white, fontSize: 17.0),
  //   //             ),
  //   //           ),
  //   //           Padding(
  //   //             padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
  //   //             child: Text(
  //   //               vItem.subtitle!,
  //   //               style: GoogleFonts.sourceSansPro(
  //   //                   fontWeight: FontWeight.w200,
  //   //                   color: Colors.white,
  //   //                   fontSize: 12.0),
  //   //             ),
  //   //           ),
  //   //           Padding(
  //   //             padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  //   //             child: Row(
  //   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //               children: [
  //   //                 SizedBox(
  //   //                   height: 40.0,
  //   //                   width: 60.0,
  //   //                   child: Row(
  //   //                     children: [
  //   //                       Text(
  //   //                         '',
  //   //                         style: GoogleFonts.sourceSansPro(
  //   //                             fontWeight: FontWeight.bold,
  //   //                             color: ColorPalette().coffeeSelected,
  //   //                             fontSize: 20.0),
  //   //                       ),
  //   //                       Text(
  //   //                         vItem.price.toString(),
  //   //                         style: GoogleFonts.sourceSansPro(
  //   //                             fontWeight: FontWeight.bold,
  //   //                             color: Colors.white,
  //   //                             fontSize: 20.0),
  //   //                       )
  //   //                     ],
  //   //                   ),
  //   //                 ),
  //   //                 GestureDetector(
  //   //                   onTap: () {
  //   //                     //To Do
  //   //                   },
  //   //                   child: Container(
  //   //                     height: 30.0,
  //   //                     width: 30.0,
  //   //                     decoration: BoxDecoration(
  //   //                         color: ColorPalette().coffeeSelected,
  //   //                         borderRadius: BorderRadius.circular(10.0)),
  //   //                     child: const Center(
  //   //                       child: Icon(
  //   //                         Icons.add,
  //   //                         size: 11.0,
  //   //                         color: Colors.white,
  //   //                       ),
  //   //                     ),
  //   //                   ),
  //   //                 )
  //   //               ],
  //   //             ),
  //   //           )
  //   //         ],
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }

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
