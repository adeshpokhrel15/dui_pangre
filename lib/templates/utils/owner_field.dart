import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/image_provider.dart';
import '../../providers/post_provider.dart';

class OwnerField extends StatelessWidget {
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

  OwnerField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (contet, ref, child) {
      final dbimage1 = ref.watch(imageProvider);
      final dbimage2 = ref.watch(imageProvider);
      final auth = FirebaseAuth.instance.currentUser!.uid;
      var children2 = [
        const Center(
          child: Text(
            "Welcome Owner",
            style: TextStyle(fontSize: 20, color: Colors.black26),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        textField(hintText: 'Citizenship No.', controller: _citizenshipnumber),
        const SizedBox(
          height: 10,
        ),
        textField(hintText: 'Phone number', controller: phonenumberController),

        const SizedBox(
          height: 10,
        ),
        textField(hintText: 'Vehicle Name', controller: vehiclenameController),
        const SizedBox(
          height: 10,
        ),
        textField(hintText: 'Vehicle CC', controller: bikeccController),
        const SizedBox(
          height: 10,
        ),
        textField(hintText: 'Vehicle Model', controller: bikemodelController),
        const SizedBox(
          height: 10,
        ),
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: dbimage1.image == null
                ? const Center(
                    child: Text(
                      "Please select License pic",
                      style: TextStyle(
                        color: Color.fromARGB(255, 70, 68, 68),
                        fontSize: 16,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(dbimage1.image!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),

        const SizedBox(
          height: 10,
        ),
        textField(
            controller: vehicledetailsController, hintText: 'Vehicle Details'),
        const SizedBox(
          height: 10,
        ),
        textField(
          controller: bikeccController,
          hintText: 'Vehicle Color',
        ),
        const SizedBox(
          height: 10,
        ),
        textField(
          controller: rentpriceController,
          hintText: 'Rent Price',
        ),
        const SizedBox(height: 10),
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: dbimage1.image == null
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
                    child: Image.file(
                      File(dbimage2.image!.path),
                      fit: BoxFit.cover,
                    ),
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

              final response = await ref.read(postCRUDprovider).addPost(
                    userId: auth,
                    citizenshipno: _citizenshipnumber.text.trim(),
                    phonenumber: int.parse(phonenumberController.text.trim()),
                    bikeCC: bikeccController.text.trim(),
                    bikemodel: bikemodelController.text.trim(),
                    bikecolor: bikecolorController.text.trim(),
                    vehicledetail: vehicledetailsController.text.trim(),
                    rentprice: int.parse(rentpriceController.text.trim()),
                    licenceimageId: dbimage1.image!,
                    bikepic: dbimage2.image!,
                    vehiclename: vehiclenameController.text.trim(),
                  );
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
              "Submit",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            // You can also use other properties like minimumSize, maximumSize, etc.
          ),
        ),
        // SizedBox(
        //     height: 45,
        //     child: MaterialButton(
        //         color: Colors.green,
        //         onPressed: () async {
        //           _form.currentState!.save();
        //           if (dbimage.image == null) {
        //             ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                     content: Text("Please select image")));
        //           } else {
        //             final response = await ref
        //                 .read(postCRUDprovider)
        //                 .addPost(
        //                   userId: auth,
        //                   citizenshipno: _citizenshipnumber.text.trim(),
        //                   phonenumber: int.parse(
        //                       phonenumberController.text.trim()),
        //                   bikeCC:
        //                       // int.parse(bikeccController.text.trim()),
        //                       bikeccController.text.trim(),
        //                   bikemodel: bikemodelController.text.trim(),
        //                   bikecolor: bikecolorController.text.trim(),
        //                   vehicledetail:
        //                       vehicledetailsController.text.trim(),
        //                   rentprice: int.parse(
        //                       rentpriceController.text.trim()),
        //                   licenceimageId: dbimage.image!,
        //                   bikepic: dbimage.image!,
        //                 );
        //           }
        //           //   final response = await ref
        //         },
        //         child: const Text(
        //           "Submit",
        //           style: TextStyle(fontSize: 16),
        //         )))
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

  TextFormField textField({
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: const Color.fromARGB(255, 235, 233, 233),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: Color.fromARGB(198, 39, 38, 38),
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16,
        ),
      ),
    );
  }
}
