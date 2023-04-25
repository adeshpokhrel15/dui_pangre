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
    double h = MediaQuery.of(context).size.height;
    final loginUserProvider =
        FutureProvider((ref) => UserProvider().getLoginUserData(auth));
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(loginUserProvider);
      return Scaffold(
          body: ListView(
        shrinkWrap: true,
        children: [
          userData.when(
            data: (data) {
              return ListView(shrinkWrap: true, children: [
                SizedBox(
                  // height: 230,
                  child: Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: h * 0.1, left: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        data.userImage1,
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    data.username,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data.email,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ]);
            },
            error: (err, stack) => Text('$err'),
            // ignore: prefer_const_constructors
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(Icons.format_quote_outlined),
            title: Text('FAQ'),
          ),
          InkWell(
            onTap: () async {
              String value = await ref.read(logSignProvider).logOut();
              if (value == 'success') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => const LoginScreen())));
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
        ],
      ));
    });
  }
}
