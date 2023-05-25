// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:two_wheelers/templates/screens/edit_post_screen.dart';

import '../../models/post_model.dart';
import '../../providers/post_provider.dart';

class ItemDetails extends StatefulWidget {
  final Post vItem;
  final PostProvider postProvider;

  const ItemDetails({
    Key? key,
    required this.vItem,
    required this.postProvider,
  }) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int selectedIndex = 0;
  final Color _iconColor = Colors.grey;
  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer(builder: (context, ref, watch) {
      return Scaffold(
          body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            color: const Color.fromARGB(255, 56, 52, 52).withOpacity(0.98),
          ),
          Hero(
              tag: 'hi',
              child: Container(
                height: (screenHeight / 2) + 70.0,
                width: screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.vItem.licenceimageId),
                        fit: BoxFit.cover)),
              )),
          Positioned(
              top: 35.0,
              left: 10.0,
              child: Container(
                color: Colors.transparent,
                height: 50.0,
                width: screenWidth - 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 224, 228, 233),
                            border: Border.all(
                                color: const Color(0xFF322B2E), width: 1.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color.fromARGB(212, 0, 0, 0),
                          size: 17.0,
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditPostScreen(post: widget.vItem, )));
                    }, icon: Icon(Icons.edit)),
                  ],
                ),
              )),
          Positioned(
            top: (screenHeight / 2) - 30.0,
            child: GlassContainer(
              height: 150.0,
              width: screenWidth,
              blur: 4,
              border: const Border.fromBorderSide(BorderSide.none),
              borderRadius: BorderRadius.circular(30.0),
              color: const Color.fromARGB(255, 124, 120, 120).withOpacity(0.3),
              child: SizedBox(
                height: 140.0,
                width: screenWidth - 20.0,
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 25.0),
                        height: 140.0,
                        width: (screenWidth - 20.0) / 2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vItem.vehiclename,
                                style: GoogleFonts.sourceSansPro(
                                    color: const Color.fromARGB(
                                        255, 235, 232, 232),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.vItem.bikemodel,
                                style: GoogleFonts.sourceSansPro(
                                    color: const Color.fromARGB(
                                        255, 202, 196, 196),
                                    fontSize: 17.0),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: const [
                                  // const Icon(
                                  //   Icons.star,
                                  // ),
                                  // const SizedBox(height: 15.0),
                                  // Row(
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           'Duration',
                                  //           style: GoogleFonts.sourceSansPro(
                                  //               color: Colors.white,
                                  //               fontSize: 15.0),
                                  //         ),
                                  //         const SizedBox(height: 5.0),
                                  //         Text(
                                  //           '2 Days',
                                  //           style: GoogleFonts.sourceSansPro(
                                  //               color: Colors.grey,
                                  //               fontSize: 14.0),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(width: 25.0),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           'Distance',
                                  //           style: GoogleFonts.sourceSansPro(
                                  //               color: Colors.white,
                                  //               fontSize: 15.0),
                                  //         ),
                                  //         const SizedBox(height: 5.0),
                                  //         Text(
                                  //           '65 KM',
                                  //           style: GoogleFonts.sourceSansPro(
                                  //               color: Colors.grey,
                                  //               fontSize: 14.0),
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            ]))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: (screenHeight / 2) + 135.0,
              child: GlassContainer(
                height: screenHeight - ((screenHeight / 2) + 120.0),
                width: screenWidth,
                blur: 4,
                border: const Border.fromBorderSide(BorderSide.none),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: const Color.fromARGB(255, 56, 52, 52).withOpacity(0.3),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Row(
                          children: [
                            Text(
                              'Status: ',
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              child: Icon(
                                Icons.circle,
                                color: widget.vItem.isreserved
                                    ? Colors
                                        .red // set color based on availability
                                    : Colors.green,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.vItem.isreserved
                                  ? 'Reserved'
                                  : 'Available', // display text based on availability
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                        child: Text(
                          'Description',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                        child: SizedBox(
                          width: screenWidth - 60.0,
                          child: Text(
                            widget.vItem.vehicledetail,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 5.0),
                        child: Text(
                          'Pickup location',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                        child: SizedBox(
                          width: screenWidth - 60.0,
                          child: Text(
                            widget.vItem.location,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 5.0),
                        child: Text(
                          'Bike CC',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                        child: SizedBox(
                          width: screenWidth - 60.0,
                          child: Text(
                            widget.vItem.bikeCC,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 5.0),
                        child: Text(
                          'Rent Price',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                        child: SizedBox(
                          width: screenWidth - 60.0,
                          child: Text(
                            'Rs. ${widget.vItem.rentprice} .per day',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showOrderBottomSheet();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 140, 0)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 15.0),
                            child: Text(
                              'Order Now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ))
        ],
      ));
    });
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void showOrderBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pickupLocationController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Location',
                ),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'How many days?',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  payWithKhaltiInApp();
                },
                child: const Text('Pay with Khalti'),
              ),
            ],
          ),
        );
      },
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
              child: const Text('OK'),
              onPressed: () async {
                // Update Firestore document
                final infoToUpdate = {
                  'isReserved': true,
                };
                await widget.postProvider
                    .updatePost(widget.vItem.id, infoToUpdate);

                // Update the local widget data
                setState(() {
                  widget.vItem.isreserved = true;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
