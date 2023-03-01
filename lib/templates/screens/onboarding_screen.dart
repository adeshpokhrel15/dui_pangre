// import 'package:flutter/material.dart';
// import 'package:two_wheelers/constant/app_constant.dart';
// import 'package:two_wheelers/views/auth_screen.dart';
// import 'package:two_wheelers/views/onboarding%20screen/slider.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentPage = 0;
//   final PageController _controller = PageController();

//   final List<Widget> _pages = [
//     const SliderPage(
//         title: "Keep",
//         description:
//             "Accept cryptocurrencies and digital assets, keep thern here, or send to orthers",
//         image: AppConstant.image1),
//     const SliderPage(
//         title: "Buy",
//         description:
//             "Buy Bitcoin and cryptocurrencies with VISA and MasterVard right in the App",
//         image: AppConstant.image2),
//     const SliderPage(
//         title: "Sell",
//         description:
//             "Sell your Bitcoin cryptocurrencies or Change with orthres digital assets or flat money",
//         image: AppConstant.image3),
//   ];

//   _onchanged(int index) {
//     setState(() {
//       _currentPage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           PageView.builder(
//             scrollDirection: Axis.horizontal,
//             onPageChanged: _onchanged,
//             controller: _controller,
//             itemCount: _pages.length,
//             itemBuilder: (context, int index) {
//               return _pages[index];
//             },
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List<Widget>.generate(_pages.length, (int index) {
//                     return AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         height: 10,
//                         width: (index == _currentPage) ? 30 : 10,
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 30),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: (index == _currentPage)
//                                 ? Colors.blue
//                                 : Colors.blue.withOpacity(0.5)));
//                   })),
//               InkWell(
//                 onTap: () {
//                   _controller.nextPage(
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeInOutQuint);
//                 },
//                 child: AnimatedContainer(
//                   alignment: Alignment.center,
//                   duration: const Duration(milliseconds: 300),
//                   height: 70,
//                   width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(35)),
//                   child: (_currentPage == (_pages.length - 1))
//                       ? MaterialButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => loginScreen()));
//                           },
//                           child: const Text(
//                             "Get Started",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         )
//                       : const Icon(
//                           Icons.navigate_next,
//                           size: 50,
//                           color: Colors.white,
//                         ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:two_wheelers/templates/screens/login_screen.dart';

class OnBoardingSreen extends StatelessWidget {
  const OnBoardingSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_vuubgscl.json')),
            const SizedBox(
              height: 50,
            ),
            const Text('Welcome to Dui Pangree',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text('Click me'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
