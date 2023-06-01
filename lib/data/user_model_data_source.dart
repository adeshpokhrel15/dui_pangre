import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import 'package:http/http.dart' as http;

import '../templates/managers/global_variables.dart';

final userProvider = StreamProvider((ref) => UserProvider().getUsers());

final currentUserProvider =
    Provider((ref) => UserProvider());
// final currentUserProvider =
//     ChangeNotifierProvider.autoDispose((ref) => UserProvider());


class UserProvider extends ChangeNotifier {
  final CollectionReference _dbModel =
      FirebaseFirestore.instance.collection('users');
  Stream<List<User>> getUsers() {
    final data = _dbModel.snapshots().map((event) => _getFromSnap(event));

    return data;
  }

  List<User> _getFromSnap(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  Future<User> getLoginUserData(String userId) async {
    final response = await _dbModel.where('userId', isEqualTo: userId).get();
    return User.fromJson(response.docs[0].data() as Map<String, dynamic>);
  }

  Future<User?> getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') as String;
      final response = await http.get(
        Uri.parse('${GlobalVariables.BASE_URI}/api/users/current/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Acess-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
        },
      );

      // print(response.body);

      // print(responseBody);

      if (response.statusCode == 200) {
        var temp = json.decode(response.body);
        print(temp['user']);
        return userFromJson(json.encode(json.decode(response.body)['user']));
      }
      return null;
    } on HttpException catch (e) {
      return null;
    } on FormatException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

}
