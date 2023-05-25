import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_wheelers/templates/screens/home_screen.dart';

import '../../models/post_model.dart';
import '../../providers/post_provider.dart';
import '../widgets/buttom_navigation_bar.dart';
import 'item_details_screen.dart';

class VehicleRequestsScreen extends StatefulWidget {
  const VehicleRequestsScreen({super.key});

  @override
  State<VehicleRequestsScreen> createState() => _VehicleRequestsScreenState();
}

class _VehicleRequestsScreenState extends State<VehicleRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Requests'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final _apiProvider = ref.watch(apiProvider);
        return FutureBuilder(
            future: _apiProvider.getVehicleRequestsFromApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                
                return snapshot.data!.isEmpty ? Center(child: Text('No request found')): GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 300,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemDetails(
                                    vItem: snapshot.data![index],
                                    postProvider: ref.read(postCRUDprovider),
                                  )));
                        },
                        // child: itemdetails(snapshot.data!, index),
                        child: Column(
                          children: [
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              width: 300,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC0BBBB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment
                                  //           .spaceBetween,
                                  //   children: [
                                  //     Container(
                                  //       padding:
                                  //           const EdgeInsets
                                  //               .all(5),
                                  //       decoration:
                                  //           BoxDecoration(
                                  //         color: const Color(
                                  //             0xFF325E83),
                                  //         borderRadius:
                                  //             BorderRadius
                                  //                 .circular(
                                  //                     20),
                                  //       ),
                                  //       child: Text(
                                  //         '4.5',
                                  //         style: GoogleFonts
                                  //             .sourceSansPro(
                                  //           fontWeight:
                                  //               FontWeight
                                  //                   .bold,
                                  //           color: Colors
                                  //               .white,
                                  //           fontSize:
                                  //               13.0,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     const Icon(
                                  //       Icons
                                  //           .favorite_border,
                                  //       color: Colors.red,
                                  //     ),
                                  //   ],
                                  // ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data![index].licenceimageId),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data![index].vehiclename,
                                        style: GoogleFonts.sourceSansPro(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0E0D0D),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].bikemodel,
                                        style: GoogleFonts.sourceSansPro(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0E0D0D),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(height: 8),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Rs.${data[index].rentprice.toString()}',
                                  //       style: GoogleFonts.sourceSansPro(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: const Color(0xFF0E0D0D),
                                  //         fontSize: 16.0,
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       height: 30.0,
                                  //       width: 30.0,
                                  //       decoration: BoxDecoration(
                                  //         color: const Color(0xFFA28764),
                                  //         borderRadius: BorderRadius.circular(10.0),
                                  //       ),
                                  //       child: const Center(
                                  //         child: Icon(
                                  //           Icons.add,
                                  //           size: 11.0,
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () async{
                                            var result = await _apiProvider.acceptVehicleRequest(
                                                snapshot.data![index].id);
                                            if(result== 'success'){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Request accepted successfully')));
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const BottomNavigationBarWidgets()));
                                            }
                                          },
                                          child: const Text('Accept')),
                                      // ElevatedButton(onPressed: (){}, child: const Text('Accept'),),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                          onPressed: () async{
                                            var result = await _apiProvider.rejectVehicleRequest(
                                                snapshot.data![index].id);
                                            if(result== 'success'){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Request Rejected successfully')));
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const BottomNavigationBarWidgets()));
                                            }
                                          },
                                          child: const Text('Reject')),

                                      //   ElevatedButton(onPressed: (){}, child: const Text('Reject'),),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
              return const Text('Something went wrong');
            });
      }),
    );
  }
}
