import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_wheelers/templates/screens/login_screen.dart';
import 'package:two_wheelers/templates/widgets/buttom_navigation_bar.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  // @override
  _getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      // print('here');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarWidgets()),
      );
    } else
    // print('here');
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    _getSession();
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer(builder: ((context, ref, child) {
  //     final auth = ref.watch(authProvider);
  //     return auth.when(
  //         data: (data) {
  //           if (data == null) {
  //             return const LoginScreen();
  //           } else {
  //             return const BottomNavigationBarWidgets();
  //           }
  //         },
  //         error: (err, stack) => Text('$err'),
  //         loading: () => const CircularProgressIndicator());
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
