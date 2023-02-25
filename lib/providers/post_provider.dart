import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_wheelers/features/models/post_model.dart';

final postStream = StreamProvider((ref) => PostProvider().getPost());
final postCRUDprovider = Provider((ref) => PostProvider());

class PostProvider {
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');
  Future<String> addPost({
    required String userId,
    required String citizenshipno,
    required int phonenumber,
    required int bikeCC,
    required String bikemodel,
    required XFile licenceimageId,
    required String vehicledetail,
    required String bikecolor,
    required int rentprice,
    required XFile bikepic,
  }) async {
    try {
      final licenceimageFile =
          File(licenceimageId.path); //converting the image to File type
      final bikeimageFile =
          File(bikepic.path); //converting the image to File type
      final licenceimageID = DateTime.now().toString();
      final bikeimageID = DateTime.now().toString();
      final ref1 = FirebaseStorage.instance.ref().child(
          'licenceImages/$licenceimageID'); //path to push the image to firebase storage
      final ref2 = FirebaseStorage.instance.ref().child(
          'bikeImages/$bikeimageID'); //path to push the image to firebase storage

      await ref1
          .putFile(licenceimageFile); //pushing the image to firebase storage
      await ref2.putFile(bikeimageFile); //pushing the image to firebase storage

      final url1 = await ref1.getDownloadURL(); //getting the url of the image
      final url2 = await ref2.getDownloadURL(); //getting the url of the image

      dbPost.add({
        'citizenshipno': citizenshipno,
        'phonenumber': phonenumber,
        'bikeCC': bikeCC,
        'bikemodel': bikemodel,
        'licenceimageId': url1,
        'vehicledetail': vehicledetail,
        'bikecolor': bikecolor,
        'rentprice': rentprice,
        'bikepic': url2,
        'userId': userId,
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
        id: e.id,
        userId: data['userId'],
      );
    }).toList();
  }
}
