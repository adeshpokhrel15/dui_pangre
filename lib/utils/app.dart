import 'package:flutter/material.dart';
import 'package:two_wheelers/views/screens/home_screen.dart';

import '../views/screens/setting_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SettingPage());
  }
}
