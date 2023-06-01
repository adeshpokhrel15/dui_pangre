import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/post_model.dart';
import '../../providers/image_provider.dart';
import '../../providers/post_provider.dart';
import '../widgets/buttom_navigation_bar.dart';

class EditPostScreen extends StatefulWidget {
  EditPostScreen({required this.post});

  Post post;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  String _selectedLocationOrder = 'Chabel';

  final List<String> _locationOrderOptions = [
    'Chabel',
    'Koteshwor',
    'New Road',
    'Thapathali'
  ];

  final TextEditingController _citizenshipnumber = TextEditingController();
  final TextEditingController vehicledetailsController =
      TextEditingController();

  final TextEditingController bikemodelController = TextEditingController();

  final TextEditingController bikeccController = TextEditingController();

  final TextEditingController bikecolorController = TextEditingController();

  final TextEditingController rentpriceController = TextEditingController();

  final TextEditingController phonenumberController = TextEditingController();

  final TextEditingController vehiclenameController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Post _selectedPost = widget.post;
    _citizenshipnumber.text = _selectedPost.citizenshipno;
    vehicledetailsController.text = _selectedPost.vehicledetail;
    bikemodelController.text = _selectedPost.bikemodel;
    bikeccController.text = _selectedPost.bikeCC;
    bikecolorController.text = _selectedPost.bikecolor;
    rentpriceController.text = _selectedPost.rentprice.toString();
    phonenumberController.text = _selectedPost.phonenumber.toString();
    vehiclenameController.text = _selectedPost.vehiclename;

    return Consumer(builder: (contet, ref, child) {
      final dbimage1 = ref.watch(imageProvider);
      final dbimage2 = ref.watch(imageProvider1);
      // final auth = FirebaseAuth.instance.currentUser!.uid;
      var children2 = [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              width: 50,
            ),
            const Center(
              child: Text(
                "Welcome Owner",
                style: TextStyle(fontSize: 20, color: Colors.black26),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          // initialValue: _selectedPost.citizenshipno,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: _citizenshipnumber,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Citizenship No.'),
        ),

        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.phonenumber.toString(),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: phonenumberController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Phone number'),
        ),
        // textField(hintText: 'Phone number', controller: phonenumberController),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.vehiclename,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: vehiclenameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Vehicle Name'),
        ),
        // textField(hintText: 'Vehicle Name', controller: vehiclenameController),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.phonenumber.toString(),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: phonenumberController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Phone number'),
        ),
        TextFormField(
          // initialValue: _selectedPost.bikeCC,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: bikeccController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Vehicle CC'),
        ),
        // textField(hintText: 'Vehicle CC', controller: bikeccController),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.bikemodel,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: bikemodelController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Vehicle Model'),
        ),
        // textField(hintText: 'Vehicle Model', controller: bikemodelController),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Place near to you',
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0E0D0D),
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value: _selectedLocationOrder,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocationOrder = newValue!;
                  });
                },
                items: _locationOrderOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(imageProvider.notifier).getImage();
                  },
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: dbimage2.image == null
                        ? const Center(
                            child: Text(
                              "Please select Vehicle pic",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 68, 68),
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _selectedPost.licenceimageId != null
                                ? Image.network(_selectedPost.licenceimageId)
                                : Image.file(
                                    File(dbimage1.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.vehicledetail,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: vehicledetailsController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Vehicle Details'),
        ),
        // textField(
        //     controller: vehicledetailsController, hintText: 'Vehicle Details'),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.bikecolor,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: bikecolorController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Vehicle Color'),
        ),
        // textField(
        //   controller: bikecolorController,
        //   hintText: 'Vehicle Color',
        // ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // initialValue: _selectedPost.rentprice.toString(),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: rentpriceController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Rent Price'),
        ),
        // textField(
        //   controller: rentpriceController,
        //   hintText: 'Rent Price',
        // ),
        const SizedBox(height: 10),
        Container(
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(imageProvider1.notifier).getImage();
                  },
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: dbimage2.image == null
                        ? const Center(
                            child: Text(
                              "Please select Bluebook pic",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 68, 68),
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _selectedPost.bikepic != null
                                ? Image.network(_selectedPost.bikepic)
                                : Image.file(
                                    File(dbimage2.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 56,
          child: MaterialButton(
            color: Colors.green,
            onPressed: () async {
              _form.currentState!.save();
              _form.currentState!.validate();
              FocusScope.of(context).unfocus();

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Loading'),
                  );
                },
              );

              try {
                String value =
                    await ref.read(postCRUDprovider).updatePostFromApi(
                          _selectedPost.id,
                          {
                            'userId': '11',
                            'citizenshipno': _citizenshipnumber.text.trim(),
                            'phonenumber': phonenumberController.text.trim(),
                            'bikeCC': bikeccController.text.trim(),
                            'bikemodel': bikemodelController.text.trim(),
                            'bikecolor': bikecolorController.text.trim(),
                            'vehicledetail':
                                vehicledetailsController.text.trim(),
                            'rentprice': rentpriceController.text.trim(),
                            'vehicleName': vehiclenameController.text.trim(),
                            'location': _selectedLocationOrder,
                          },
                          dbimage1.image == null && dbimage2.image == null
                              ? null
                              : [
                                  dbimage1.image!,
                                  dbimage2.image!,
                                ],
                        );

                Navigator.of(context).pop(); // Close the loading dialog

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Information updated successfully'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              // builder: (context) => CartScreen(),
                              builder: (context) =>
                                  BottomNavigationBarWidgets(),
                            ));
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } catch (error) {
                Navigator.of(context).pop(); // Close the loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text('An error occurred: $error'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            // ButtonStyle configuration
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            elevation: 5,
            highlightElevation: 10,
            hoverElevation: 10,
            disabledElevation: 0,
            splashColor: Colors.white,
            highlightColor: Colors.white,
            child: const Text(
              "Update",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            // You can also use other properties like minimumSize, maximumSize, etc.
          ),
        ),

        // SizedBox(
        //   height: 56,
        //   child: MaterialButton(
        //     color: Colors.green,
        //     onPressed: () async {
        //       _form.currentState!.save();
        //       _form.currentState!.validate();
        //       FocusScope.of(context).unfocus();
        //       AlertDialog(
        //         title: const Text('Success'),
        //         content: const Text('Your post has been added'),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pushReplacement(MaterialPageRoute(
        //                   builder: ((context) => const HomeScreen())));
        //             },
        //             child: const Text('OK'),
        //           ),
        //         ],
        //       );
        //       String value = await ref.read(postCRUDprovider).addPost(
        //             userId: auth,
        //             citizenshipno: _citizenshipnumber.text.trim(),
        //             phonenumber: int.parse(phonenumberController.text.trim()),
        //             bikeCC: bikeccController.text.trim(),
        //             bikemodel: bikemodelController.text.trim(),
        //             bikecolor: bikecolorController.text.trim(),
        //             vehicledetail: vehicledetailsController.text.trim(),
        //             rentprice: int.parse(rentpriceController.text.trim()),
        //             licenceimageId: dbimage1.image!,
        //             bikepic: dbimage2.image!,
        //             vehiclename: vehiclenameController.text.trim(),
        //           );
        //     },
        //     // ButtonStyle configuration
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        //     elevation: 5,
        //     highlightElevation: 10,
        //     hoverElevation: 10,
        //     disabledElevation: 0,

        //     splashColor: Colors.white,
        //     highlightColor: Colors.white,
        //     child: const Text(
        //       "Submit",
        //       style: TextStyle(fontSize: 16, color: Colors.white),
        //     ),
        //     // You can also use other properties like minimumSize, maximumSize, etc.
        //   ),
        // ),
      ];
      return SafeArea(
        child: Scaffold(
          body: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: children2,
              ),
            ),
          ),
        ),
      );
    });
  }
}
