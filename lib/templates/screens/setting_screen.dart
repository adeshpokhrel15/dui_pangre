import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/templates/screens/login_screen.dart';

import '../../providers/auth_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget listTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(children: [
      const Divider(
        height: 1,
      ),
      ListTile(
        leading: Icon(
          icon,
          size: 18,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, color: Colors.black),
        ),
        trailing: Text(value,
            style: const TextStyle(fontSize: 21, color: Colors.grey)),
      ),
    ]);
  }

  bool state = false;
  bool state2 = false;
  bool state3 = false;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ref, child) {
      return SafeArea(
          child: Scaffold(
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SETTINGS',
                        style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.red,
                        child: const Icon(
                          Icons.border_color,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: h * 0.17, left: 28),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://th.bing.com/th/id/R.e89172ddf5a8618b0ff2c426a5d4703f?rik=L%2fOiKf1NywNDSg&pid=ImgRaw&r=0",
                            ))),
                  ),
                  const SizedBox(width: 20),
                  Stack(children: const [
                    Text('NAHO JOBS ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 30),
                      child: Text('Beginner',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ]),
                ],
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 20,
              color: Colors.grey,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 2),
                child: Text(
                  'Account Info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Notification",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: CupertinoSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Account activity",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: CupertinoSwitch(
                        value: state2,
                        onChanged: (value2) {
                          state2 = value2;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Oppportunity",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: CupertinoSwitch(
                        value: state3,
                        onChanged: (value3) {
                          state3 = value3;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
            width: 120,
            child: MaterialButton(
              onPressed: () async {
                String value = await ref.read(logSignProvider).logOutFromApi();
                if (value == 'success') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const LoginScreen())));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              elevation: 5.0,
              color: Colors.lightGreen,
              textColor: Colors.black,
              child: const Text('Log Out'),
            ),
          ),
        ]),
      ));
    });
  }
}
