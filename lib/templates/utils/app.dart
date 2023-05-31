import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:two_wheelers/templates/screens/status_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_35f900550bf448f1af2856f22adf3c75",
        builder: (context, navigatorKey) {
          return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              home: const StatusScreen());
          // home: const MapSample());
        });
  }
}
