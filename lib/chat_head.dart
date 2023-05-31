import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class RandomPage1 extends StatelessWidget {
  const RandomPage1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Page 1'),
        ),
        body: Marquee(
          text: 'Some sample text that takes some space.',
          style: const TextStyle(fontWeight: FontWeight.bold),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 100.0,
          startPadding: 10.0,
        ));
  }
}
