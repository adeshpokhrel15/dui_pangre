import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/post_model.dart';

final postCrudProvider = Provider((ref) => PostProvider());
final postStream = StreamProvider((ref) => PostProvider().getPost());

class PostProvider {
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');
  Future<String> addPost({
    required String citizenshipno,
    required int phonenumber,
    required String bikeCC,
    required String bikemodel,
    required XFile licenceimageId,
    required String vehicledetail,
    required String bikecolor,
    required int rentprice,
    required XFile bikepic,
  }) async {
    try {
      final imageFile1 = File(bikepic.path); //converting the image to File type
      final imageFile2 = File(licenceimageId.path);
      final imageID = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child(
          'postImages/$imageID'); //path to push the image to firebase storage

      await ref.putFile(imageFile1); //pushing the image to firebase storage
      await ref.putFile(imageFile2);

      final url = await ref.getDownloadURL(); //getting the url of the image

      dbPost.add({
        'citizenshipno': citizenshipno,
        'phonenumber': phonenumber,
        'bikeCC': bikeCC,
        'bikemodel': bikemodel,
        'licenceimageId': licenceimageId,
        'vehicledetail': vehicledetail,
        'bikecolor': bikecolor,
        'rentprice': rentprice,
        'bikepic': bikepic,
      });

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

  Stream<List<Post>> getPost() {
    final data = dbPost.snapshots().map((event) => _getFromSnap(event));

    return data;
  }

  List<Post> _getFromSnap(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final data = e.data() as Map<String, dynamic>;
      return Post(
        citizenshipno: data['citizenshipno'],
        phonenumber: data['phonenumber'],
        bikeCC: data['bikeCC'],
        bikemodel: data['bikemodel'],
        licenceimageId: data['licenceimageId'],
        vehicledetail: data['vehicledetail'],
        bikecolor: data['bikecolor'],
        rentprice: data['rentprice'],
        bikepic: data['bikepic'],
      );
    }).toList();
  }
}
