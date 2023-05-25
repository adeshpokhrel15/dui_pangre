import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final cartPosts = ref.watch(cartPostProvider);
      return Scaffold(
          appBar: AppBar(
            title: const Text("Cart Screen"),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: cartPosts.cartPosts.length,
              itemBuilder: (context, index) {
                final data = cartPosts.cartPosts[index];
                return Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.vehicleName,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0E0D0D),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    data.bikeModel,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0E0D0D),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs.${data.rentPrice.toString()}',
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0E0D0D),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          
                                        },
                                        child: Container(
                                          height: 30.0,
                                          width: 30.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFA28764),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.edit,
                                              size: 11.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 30.0,
                                          width: 30.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFA28764),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete,
                                              size: 11.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              }));
    });
  }
}
