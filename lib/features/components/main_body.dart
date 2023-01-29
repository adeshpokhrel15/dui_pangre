import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class MainBody extends StatelessWidget {
  const MainBody(
      {Key? key,
      required this.child,
      this.padding = const EdgeInsets.only(top: 40.0) // Default padding
      })
      : super(key: key);

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }
}
