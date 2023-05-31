import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:two_wheelers/templates/screens/vehicle_requests_screen.dart';
import 'package:two_wheelers/templates/widgets/drawer_widgets.dart';

import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';

var tstyle = TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 50);

class BottomNavigationBarWidgets extends StatefulWidget {
  const BottomNavigationBarWidgets({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetsState createState() =>
      _BottomNavigationBarWidgetsState();
}

class _BottomNavigationBarWidgetsState
    extends State<BottomNavigationBarWidgets> {
  var padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 5);
  double gap = 6;

  int _index = 0;
  List pages = [
    const HomeScreen(),
    CartScreen(),
    VehicleRequestsScreen(),
    DrawerWidgets()
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView.builder(
          itemCount: 4,
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              _index = page;
            });
          },
          itemBuilder: (context, position) {
            return Center(child: pages[position]);
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0, 25),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: GNav(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: gap,
                  icon: Icons.home,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.purple,
                  text: 'Home',
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.home,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.purple,
                  text: 'Cart',
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.home,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.purple,
                  text: 'Requests',
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.people,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.grey,
                  text: 'Settings',
                  textColor: Colors.black,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
