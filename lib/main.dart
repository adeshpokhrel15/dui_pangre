import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_wheelers/providers/user_provider.dart';
import 'package:two_wheelers/utils/app.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}
