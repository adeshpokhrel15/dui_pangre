import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_model.dart';

final postStream = StreamProvider((ref) => PostProvider().getPosts());

final postCRUDprovider = Provider((ref) => PostProvider());

class PostProvider {
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');
  CollectionReference dbReserved =
      FirebaseFirestore.instance.collection('isreserved');

  Future<String> addPost({
    required String userId,
    required String citizenshipno,
    required int phonenumber,
    required String bikeCC,
    required String bikemodel,
    required XFile licenceimageId,
    required String vehicledetail,
    required String bikecolor,
    required int rentprice,
    required XFile bikepic,
    required String vehiclename,
    required String location,
    bool isReserved = false,
  }) async {
    try {
      final licenceimageFile = File(licenceimageId.path);
      final bikeimageFile = File(bikepic.path);
      final licenceimageID = DateTime.now().toString();
      final bikeimageID = DateTime.now().toString();
      final ref1 =
          FirebaseStorage.instance.ref().child('licenceImages/$licenceimageID');
      final ref2 =
          FirebaseStorage.instance.ref().child('bikeImages/$bikeimageID');

      await ref1.putFile(licenceimageFile);
      await ref2.putFile(bikeimageFile);

      final url1 = await ref1.getDownloadURL();
      final url2 = await ref2.getDownloadURL();

      final newPost = {
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
        'vehicleName': vehiclename,
        'isReserved': isReserved,
        'location': location,
      };

      await dbPost.add(newPost);

      if (isReserved) {
        await dbReserved.add(newPost);
      }

      return 'success';
    } catch (e) {
      print('Failed to add post: $e');
      return '';
    }
  }

  Future<void> updatePost(
      String postId, Map<String, dynamic> updatedData) async {
    try {
      final postDoc = dbPost.doc(postId);
      final postSnapshot = await postDoc.get();

      if (postSnapshot.exists) {
        final data = postSnapshot.data() as Map<String, dynamic>;
        final isReserved = data['isReserved'] ?? false;

        await postDoc
            .update(updatedData); // Update the post in the original collection

        if (isReserved) {
          final reservedDoc = dbReserved.doc(postId);
          await reservedDoc.update(
              updatedData); // Update the post in the reserved collection

          print('Post updated successfully in both collections');
        } else {
          final newPostData = {
            ...data, // Include all existing post data
            ...updatedData, // Include the updated fields
            'isReserved': true, // Update the status to true
          };

          await dbReserved
              .doc(postId)
              .set(newPostData); // Add the post to the reserved collection

          print('Post moved to the reserved collection');
        }
      } else {
        print('Post not found');
      }
    } catch (e) {
      print('Failed to update post: $e');
    }
  }

  Stream<List<Post>> getPosts() {
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
        location: data['location'],
        userId: data['userId'],
        vehiclename: data['vehicleName'],
      );
    }).toList();
  }
}
