// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
  // final String query;
  // const SearchPage({Key? key, required this.query}) : super(key: key);

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   List searchResult = [];
//   final TextEditingController _searchController = TextEditingController();

//   // void searchFromFirebase(String query) async {
//   //   final result = await FirebaseFirestore.instance
//   //       .collection('posts')
//   //       .where('vehicleName', isEqualTo: query)
//   //       .get();
//   //     print("resultttt hoooooo =====> $result");

//   //   setState(() {
//   //     searchResult = result.docs.map((e) => e.data()).toList();
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _searchController.text = widget.query;
//     print('hello');
//     searchFromFirebase(widget.query);
//     _searchController.addListener(() {
//       searchFromFirebase(_searchController.text);
//     });
//   }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             controller: _searchController,
//             decoration: const InputDecoration(
//               hintText: 'Search for Vehicles',
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: searchResult.length,
//           itemBuilder: (context, index) {
//             final result = searchResult[index];
//             return ListTile(
//               title: Text(result['vehicheName']),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
