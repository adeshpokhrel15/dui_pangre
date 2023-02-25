import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/image_provider.dart';
import '../providers/post_provider.dart';

class OwnerField extends StatelessWidget {
  final TextEditingController _citizenshipnumber = TextEditingController();

  final TextEditingController vehicledetailsController =
      TextEditingController();
  final TextEditingController bikemodelController = TextEditingController();
  final TextEditingController bikeccController = TextEditingController();
  final TextEditingController bikecolorController = TextEditingController();
  final TextEditingController rentpriceController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final _form = GlobalKey<FormState>();

  OwnerField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (contet, ref, child) {
      final dbimage = ref.watch(imageProvider);
      final auth = FirebaseAuth.instance.currentUser!.uid;
      return Scaffold(
        body: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    "Welcome Owner",
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _citizenshipnumber,
                  decoration: const InputDecoration(
                      hintText: 'Citizenship no.',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phonenumberController,
                  decoration: const InputDecoration(
                      hintText: 'Phone number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bikeccController,
                  decoration: const InputDecoration(
                      hintText: 'Bike CC',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bikemodelController,
                  decoration: const InputDecoration(
                      hintText: 'Bike Model',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    ref.read(imageProvider.notifier).getImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        height: 140,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: dbimage.image == null
                            ? const Center(
                                child: Text("please select Licence pic"),
                              )
                            : Image.file(
                                File(dbimage.image!.path),
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: vehicledetailsController,
                  decoration: const InputDecoration(
                      hintText: 'Bike Details',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bikecolorController,
                  decoration: const InputDecoration(
                      hintText: 'Bike color',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: rentpriceController,
                  decoration: const InputDecoration(
                      hintText: 'Rent Price',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                InkWell(
                  onTap: () {
                    ref.read(imageProvider.notifier).getImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        height: 140,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: dbimage.image == null
                            ? const Center(
                                child: Text("please select Bike pic"),
                              )
                            : Image.file(
                                File(dbimage.image!.path),
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 45,
                    child: MaterialButton(
                        color: Colors.green,
                        onPressed: () async {
                          _form.currentState!.save();
                          if (dbimage.image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please select image")));
                          } else {
                            final response = await ref
                                .read(postCRUDprovider)
                                .addPost(
                                  userId: auth,
                                  citizenshipno: _citizenshipnumber.text.trim(),
                                  phonenumber: int.parse(
                                      phonenumberController.text.trim()),
                                  bikeCC: bikeccController.text.trim(),
                                  bikemodel: bikemodelController.text.trim(),
                                  bikecolor: bikecolorController.text.trim(),
                                  vehicledetail:
                                      vehicledetailsController.text.trim(),
                                  rentprice: int.parse(
                                      rentpriceController.text.trim()),
                                  licenceimageId: dbimage.image!,
                                  bikepic: dbimage.image!,
                                );
                          }
                          //   final response = await ref
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 16),
                        )))
              ],
            ),
          ),
        ),
      );
    });
  }
}
