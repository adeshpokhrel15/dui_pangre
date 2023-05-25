import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import '../templates/managers/global_variables.dart';

final postStream = StreamProvider((ref) => PostProvider().getPosts());

final postCRUDprovider = Provider((ref) => PostProvider());

final apiProvider = Provider((ref) => PostProvider());

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

// for sign up using api
  Future<String> updatePostFromApi( String postId,
      Map<String, dynamic> postBody, List<XFile>? images) async {
    try {
      var url = Uri.parse("${GlobalVariables.BASE_URI}/api/bikeinfo/$postId/");
      var request = http.MultipartRequest("PUT", url);
      // Add text fields to the request body
      request.fields['userId'] = postBody['userId'];
      request.fields['vehicleName'] = postBody['vehicleName'];
      request.fields['location'] = postBody['location'];
      request.fields['citizenshipno'] = postBody['citizenshipno'];
      request.fields['phonenumber'] = postBody['phonenumber'];
      request.fields['bikeCC'] = postBody['bikeCC'];
      request.fields['bikemodel'] = postBody['bikemodel'];
      request.fields['vehicledetail'] = postBody['vehicledetail'];
      request.fields['bikecolor'] = postBody['bikecolor'];
      request.fields['rentprice'] = postBody['rentprice'];

      if(images != null){

      // Add image files to the request body
      for (var i = 0; i < images.length; i++) {
        var imageFile = File(images[i].path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = await http.MultipartFile.fromPath(
          'images',
          imageFile.path,
        );

        request.files.add(multipartFile);
      }
      }

      var response = await request.send();

      // print(response);

      // Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseBody = String.fromCharCodes(responseData);

      // print(responseBody);

      if (response.statusCode == 200) {
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

// for sign up using api
  Future<String> addPostToApi(
      Map<String, dynamic> postBody, List<XFile> images) async {
    try {
      var url = Uri.parse("${GlobalVariables.BASE_URI}/api/bikeinfo/");
      var request = http.MultipartRequest("POST", url);
      // Add text fields to the request body
      request.fields['userId'] = postBody['userId'];
      request.fields['vehicleName'] = postBody['vehicleName'];
      request.fields['location'] = postBody['location'];
      request.fields['citizenshipno'] = postBody['citizenshipno'];
      request.fields['phonenumber'] = postBody['phonenumber'];
      request.fields['bikeCC'] = postBody['bikeCC'];
      request.fields['bikemodel'] = postBody['bikemodel'];
      request.fields['vehicledetail'] = postBody['vehicledetail'];
      request.fields['bikecolor'] = postBody['bikecolor'];
      request.fields['rentprice'] = postBody['rentprice'];

      // Add image files to the request body
      for (var i = 0; i < images.length; i++) {
        var imageFile = File(images[i].path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

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

  Future<void> editPost(
    String postId, {
    String? citizenshipno,
    int? phonenumber,
    String? bikeCC,
    String? bikemodel,
    XFile? licenceimageId,
    String? vehicledetail,
    String? bikecolor,
    int? rentprice,
    XFile? bikepic,
    String? vehiclename,
    String? location,
    bool? isReserved,
  }) async {
    try {
      final postDoc = dbPost.doc(postId);
      final postSnapshot = await postDoc.get();

      if (postSnapshot.exists) {
        final data = postSnapshot.data() as Map<String, dynamic>;
        final isPostReserved = data['isReserved'] ?? false;

        if (licenceimageId != null) {
          final licenceimageFile = File(licenceimageId.path);
          final licenceimageID = DateTime.now().toString();
          final ref1 = FirebaseStorage.instance
              .ref()
              .child('licenceImages/$licenceimageID');

          await ref1.putFile(licenceimageFile);
          final url1 = await ref1.getDownloadURL();
          data['licenceimageId'] = url1;
        }

        if (bikepic != null) {
          final bikeimageFile = File(bikepic.path);
          final bikeimageID = DateTime.now().toString();
          final ref2 =
              FirebaseStorage.instance.ref().child('bikeImages/$bikeimageID');

          await ref2.putFile(bikeimageFile);
          final url2 = await ref2.getDownloadURL();

          data['bikepic'] = url2;
        }

        if (citizenshipno != null) {
          data['citizenshipno'] = citizenshipno;
        }
        if (phonenumber != null) {
          data['phonenumber'] = phonenumber;
        }
        if (bikeCC != null) {
          data['bikeCC'] = bikeCC;
        }
        if (bikemodel != null) {
          data['bikemodel'] = bikemodel;
        }
        if (vehicledetail != null) {
          data['vehicledetail'] = vehicledetail;
        }
        if (bikecolor != null) {
          data['bikecolor'] = bikecolor;
        }
        if (rentprice != null) {
          data['rentprice'] = rentprice;
        }
        if (vehiclename != null) {
          data['vehicleName'] = vehiclename;
        }
        if (location != null) {
          data['location'] = location;
        }
        if (isReserved != null) {
          data['isReserved'] = isReserved;
        }

        await postDoc.update(data);

        if (isPostReserved) {
          final reservedDoc = dbReserved.doc(postId);
          await reservedDoc.update(data);

          print('Post updated successfully in both collections');
        } else {
          final newPostData = {
            ...data,
            'isReserved': true,
          };
          await dbReserved.doc(postId).set(newPostData);

          print('Post moved to the reserved collection');
        }
      } else {
        print('Post not found');
      }
    } catch (e) {
      print('Failed to update post: $e');
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

  Future<void> deletePost(String postId) async {
    try {
      final postDoc = dbPost.doc(postId);
      final postSnapshot = await postDoc.get();
      if (postSnapshot.exists) {
        final data = postSnapshot.data() as Map<String, dynamic>;
        final isReserved = data['isReserved'] ?? false;

        await postDoc.delete(); // Delete the post from the original collection

        if (isReserved) {
          final reservedDoc = dbReserved.doc(postId);
          await reservedDoc
              .delete(); // Delete the post from the reserved collection

          print('Post deleted successfully from both collections');
        } else {
          print('Post deleted successfully from the original collection');
        }
      } else {
        print('Post not found');
      }
    } catch (e) {
      print('Failed to delete post: $e');
    }
  }

  Stream<List<Post>> getPosts() {
    final data = dbPost.snapshots().map((event) => _getFromSnap(event));

    return data;
  }

  // Get posts from firebase
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

  // Get posts from api
  Future<List<Post>> getPostFromApi() async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.BASE_URI}/api/bikeinfo/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
        },
      );

      print(response.body);

      // print(responseBody);

      if (response.statusCode == 200) {
        return postsFromJson(response.body);
      }
      return <Post>[];
    } on HttpException catch (e) {
      return <Post>[];
    } on FormatException catch (e) {
      return <Post>[];
    } catch (e) {
      return <Post>[];
    }
    //   return Post(
    //     citizenshipno: data['citizenshipno'],
    //     phonenumber: data['phonenumber'],
    //     bikeCC: data['bikeCC'],
    //     bikemodel: data['bikemodel'],
    //     licenceimageId: data['licenceimageId'],
    //     vehicledetail: data['vehicledetail'],
    //     bikecolor: data['bikecolor'],
    //     rentprice: data['rentprice'],
    //     bikepic: data['bikepic'],
    //     id: e.id,
    //     location: data['location'],
    //     userId: data['userId'],
    //     vehiclename: data['vehicleName'],
    //   );
    // }).toList();
  }

  // Get requests from api
  Future<List<Post>> getVehicleRequestsFromApi() async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.BASE_URI}/api/requested-vehicles/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
        },
      );

      // print(response.body);

      // print(responseBody);

      if (response.statusCode == 200) {
        return postsFromJson(response.body);
      }
      return <Post>[];
    } on HttpException catch (e) {
      return <Post>[];
    } on FormatException catch (e) {
      return <Post>[];
    } catch (e) {
      return <Post>[];
    }
    //   return Post(
    //     citizenshipno: data['citizenshipno'],
    //     phonenumber: data['phonenumber'],
    //     bikeCC: data['bikeCC'],
    //     bikemodel: data['bikemodel'],
    //     licenceimageId: data['licenceimageId'],
    //     vehicledetail: data['vehicledetail'],
    //     bikecolor: data['bikecolor'],
    //     rentprice: data['rentprice'],
    //     bikepic: data['bikepic'],
    //     id: e.id,
    //     location: data['location'],
    //     userId: data['userId'],
    //     vehiclename: data['vehicleName'],
    //   );
    // }).toList();
  }

  // Get requests from api
  Future<String> acceptVehicleRequest(String vechicleId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            '${GlobalVariables.BASE_URI}/api/requested-vehicles/accept/$vechicleId/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
        },
      );

      // print(response.body);

      // print(responseBody);

      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      return '';
    }

    //   return Post(
    //     citizenshipno: data['citizenshipno'],
    //     phonenumber: data['phonenumber'],
    //     bikeCC: data['bikeCC'],
    //     bikemodel: data['bikemodel'],
    //     licenceimageId: data['licenceimageId'],
    //     vehicledetail: data['vehicledetail'],
    //     bikecolor: data['bikecolor'],
    //     rentprice: data['rentprice'],
    //     bikepic: data['bikepic'],
    //     id: e.id,
    //     location: data['location'],
    //     userId: data['userId'],
    //     vehiclename: data['vehicleName'],
    //   );
    // }).toList();
  }

  Future<String> rejectVehicleRequest(String vechicleId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            '${GlobalVariables.BASE_URI}/api/requested-vehicles/reject/$vechicleId/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
        },
      );

      // print(response.body);

      // print(responseBody);

      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
