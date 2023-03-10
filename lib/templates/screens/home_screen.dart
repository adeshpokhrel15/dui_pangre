import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/post_provider.dart';
import '../managers/color_palette_manager.dart';
import '../widgets/drawer_widgets.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            body: poststream.when(
                data: (data) {
                  return GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                          vItem: data[index],
                                        )));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 10,
                                  top: 10,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 192, 187, 187),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 50, 94, 131),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            '4.5',
                                            style: GoogleFonts.sourceSansPro(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                data[index].bikepic),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data[index].vehiclename,
                                            style: GoogleFonts.sourceSansPro(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 14, 13, 13),
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data[index].bikemodel,
                                            style: GoogleFonts.sourceSansPro(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 14, 13, 13),
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Rs.${data[index].rentprice.toString()}',
                                            style: GoogleFonts.sourceSansPro(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 14, 13, 13),
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          height: 30.0,
                                          width: 30.0,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorPalette().coffeeSelected,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 11.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                error: (err, stack) => Text("$err"),
                loading: () => const CircularProgressIndicator())),
      );
    });
  }
}
