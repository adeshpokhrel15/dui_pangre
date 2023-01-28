import 'package:flutter/material.dart';
import 'package:two_wheelers/utils/router.dart';
import 'package:two_wheelers/views/screens/home_screen.dart';

import '../features/data/data_source/auth_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const HomeScreen());
  }
}
