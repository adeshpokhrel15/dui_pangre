import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_wheelers/features/widgets/drawer.dart';
import 'package:two_wheelers/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      drawer: drawerWidgets(),
      appBar: AppBar(
        shadowColor: Colors.white10,
        title: const Text('Main Page'),
      ),
      body: const Center(
        child: Text('Main Page'),
      ),
    );
  }
}
