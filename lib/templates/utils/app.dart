import 'package:flutter/material.dart';
import 'package:two_wheelers/templates/screens/home_screen.dart';

import '../../chat_head.dart';
import '../screens/status_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: StatusScreen());
  }
}
