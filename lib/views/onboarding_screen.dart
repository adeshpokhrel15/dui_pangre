import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:two_wheelers/views/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => setState(() {
            isLastPage = index == 2;
          }),
          children: [
            buildPage(
                color: Colors.green,
                title: 'Welcome to Two Wheelers',
                description: 'The best place to buy your two wheelers',
                image: ('assets/images/first.png')),
            buildPage(
                color: Colors.green,
                title: 'Welcome to Two Wheelers',
                description: 'The best place to buy your two wheelers',
                image: 'assets//images/first.png'),
            buildPage(
                color: Colors.white,
                title: 'Welcome to Two Wheelers',
                description: 'The best place to buy your two wheelers',
                image: 'assets//images/first.png'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Text('Get Started'))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.jumpToPage(2);
                      },
                      child: const Text('Skip')),
                  Center(
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.teal.shade700,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)),
                  ),
                  TextButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Text('Next')),
                ],
              ),
            ),
    );
  }

  Widget buildPage({
    required Color color,
    required String title,
    required String description,
    required String image,
  }) =>
      Container(
        color: color,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ]),
        ),
      );
}
