import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/OnboardingProvider.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          OnboardingPage(
            title: "Welcome",
            description: "This is the first page of the onboarding screen.",
            image: "images/beauty.png",
          ),
          OnboardingPage(
            title: "Explore",
            description: "This is the second page of the onboarding screen.",
            image: "images/beauty.png",
          ),
          OnboardingPage(
            title: "Get Started",
            description: "This is the third page of the onboarding screen.",
            image: "images/beauty.png",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: kcontentColor,
        backgroundColor: kprimaryColor,
        onPressed: () {
          // Navigate to the next page or finish onboarding
          if (controller.page! < 2) {
            controller.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            // Mark onboarding as completed
            Provider.of<OnboardingProvider>(context, listen: false)
                .completeOnboarding();
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
