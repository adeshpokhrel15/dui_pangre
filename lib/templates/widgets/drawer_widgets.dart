import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user_model_data_source.dart';
import '../../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../utils/owner_field.dart';

class DrawerWidgets extends StatelessWidget {
  final auth = FirebaseAuth.instance.currentUser!.uid;

  DrawerWidgets({super.key});

  Widget listTile({
    required String title,
    required IconData iconData,
  }) {
    return SizedBox(
      height: 50,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          iconData,
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginUserProvider =
        FutureProvider((ref) => UserProvider().getLoginUserData(auth));
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(loginUserProvider);
      return Drawer(
          child: ListView(
        shrinkWrap: true,
        children: [
          userData.when(
            data: (data) {
              return ListView(shrinkWrap: true, children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(data.userImage)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(data.email),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ]);
            },
            error: (err, stack) => Text('$err'),
            // ignore: prefer_const_constructors
            loading: () => Center(child: CircularProgressIndicator()),
          ),

          ListTile(
            leading: const Icon(Icons.person_outlined),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text('Cart'),
            onTap: () {},
          ),
          const ListTile(
            leading: Icon(Icons.format_quote_outlined),
            title: Text('FAQ'),
          ),
          InkWell(
            onTap: () async {
              String value = await ref.read(logSignProvider).logOut();
              if (value == 'success') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              }
            },
            child: const ListTile(
              leading: Icon(Icons.exit_to_app_outlined),
              title: Text("Log Out"),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
              height: 50,
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => OwnerField())),
                );
              },
              // ButtonStyle configuration
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30),

              elevation: 5,
              highlightElevation: 10,
              hoverElevation: 10,
              disabledElevation: 0,
              splashColor: Colors.white,
              highlightColor: Colors.white,
              child: const Text(
                "Signed as Owner",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              // You can also use other properties like backgroundColor, minimumSize, maximumSize, etc.
            ),
          ),
          // Container(
          //   height: 350,
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text("Contact Support"),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         children: const [
          //           Text("Call us:"),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           Text("984125010"),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: const [
          //             Text("Mail us:"),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             Text(
          //               "duipangrenepal@gmail.com",
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ));
    });
  }
}
