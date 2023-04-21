import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final logSignProvider = Provider((ref) => LoginSignUpProvider());

class LoginSignUpProvider {
  CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users'); //connection to firestore

  // for sign up
  Future<String> signUp({
    required String email,
    required String password,
    required String userName,
    required String address,
    required XFile image1, //image type is File type
    required XFile image2,
  }) async {
    try {
      final imageFile1 = File(image1.path); //converting the image to File type
      final imageFile2 = File(image2.path);
      final imageID = DateTime.now().toString();
      final ref1 = FirebaseStorage.instance.ref().child(
          'userImages/$imageID'); //path to push the image to firebase storage
      final ref2 = FirebaseStorage.instance.ref().child(
          'bluebookImage/$imageID'); //path to push the image to firebase storage

      await ref1.putFile(imageFile1);
      await ref2.putFile(imageFile2); //pushing the image to firebase storage

      final url1 = await ref1.getDownloadURL(); //getting the url of the image
      final url2 = await ref2.getDownloadURL();

      final responseUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // print(responseUser);

      dbUsers.add({
        'email': email,
        'username': userName,
        'userId': responseUser.user!.uid,
        'address': address,
        'userImage1': url1,
        'userImage2': url2,
      });

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

// for log in
  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(response);
      return 'success';
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

//for log out
  Future<String> logOut() async {
    try {
      final response = await FirebaseAuth.instance.signOut();
      // print(FirebaseAuth.instance);
      return 'success';
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }
}
