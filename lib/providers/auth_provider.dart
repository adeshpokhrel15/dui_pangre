import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../templates/managers/global_variables.dart';

final authProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final logSignProvider = Provider((ref) => LoginSignUpProvider());

class LoginSignUpProvider {
  CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users'); //connection to firestore

  // // for sign up from firebase
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

// for sign up using api
  Future<String> signUpFromApi(
      Map<String, dynamic> postBody, List<XFile> images) async {
    try {
      var url = Uri.parse("${GlobalVariables.BASE_URI}/api/users/register/");
      var request = http.MultipartRequest("POST", url);

      // Add text fields to the request body
      request.fields['username'] = postBody['userName'];
      request.fields['email'] = postBody['email'];
      request.fields['password'] = postBody['password'];

      // Add image files to the request body
      for (var i = 0; i < images.length; i++) {
        var imageFile = File(images[i].path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        // var multipartFile = http.MultipartFile(
        //   'images',
        //   stream,
        //   length,
        //   // filename: basename(imageFile.path),
        // );
        var multipartFile = await http.MultipartFile.fromPath(
          'images',
          imageFile.path,
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();

      // print(response);

      // Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseBody = String.fromCharCodes(responseData);

      // print(responseBody);

      if (response.statusCode == 201) {
        // print('User registered successfully');
        return 'success';
      }

      return '';
    } on HttpException catch (e) {
      return '';
    } on FormatException catch (e) {
      return '';
    } catch (e) {
      return '';
    }
  }

// for log in from firebase
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

// for log in from node api
  Future<String> logInFromApi({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> postBody = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse('${GlobalVariables.BASE_URI}/api/users/login/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
        },
        body: json.encode(postBody),
      );
      // print(response);
      if (response.statusCode == 200) {
        var temp = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', json.decode(response.body)['token']);
        return 'success';
      }
      return '';
    } on SocketException catch (e) {
      print(e);
      return '';
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

// //for log out from firebase
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

//for log out using api
  Future<String> logOutFromApi() async {
    // try {
    //   final response = await FirebaseAuth.instance.signOut();
    //   // print(FirebaseAuth.instance);
    //   return 'success';
    // } on FirebaseException catch (e) {
    //   print(e);
    //   return '';
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.remove('token')) return 'success';
    return '';
  }
}
