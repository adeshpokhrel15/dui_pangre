import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:two_wheelers/views/screens/cart_screen.dart';
import 'package:two_wheelers/views/screens/home_screen.dart';
import 'package:two_wheelers/views/screens/setting_page.dart';

var tstyle = TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 50);

class BottomPageBar extends StatefulWidget {
  @override
  _BottomPageBarState createState() => _BottomPageBarState();
}

class _BottomPageBarState extends State<BottomPageBar> {
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  int _index = 0;
  List pages = [const HomeScreen(), const CartScreen(), const SettingPage()];
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  icon: Icons.shopping_cart,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.pink,
                  text: 'Cart',
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.settings,
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
