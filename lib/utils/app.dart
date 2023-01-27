import 'package:flutter/material.dart';
import 'package:two_wheelers/utils/router.dart';
import 'package:two_wheelers/views/intro_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: IntroScreen(),
    );
  }
}
