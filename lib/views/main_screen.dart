import 'package:flutter/material.dart';
import 'package:two_wheelers/features/widgets/drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
