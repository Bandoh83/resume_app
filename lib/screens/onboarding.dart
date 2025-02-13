import 'package:flutter/material.dart';
import 'package:portfolio_app/screens/forms.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/Personal data.svg",
      "description": "Our AI will create a professional resume tailored to your career path from the details you provide."
    },
    {
      "image": "assets/Chat bot.svg",
      "description": "To leave a lasting impression, our AI polishes your resume by enhancing its organization, language, and readability."
    },
    {
      "image": "assets/workers.svg",
      "description": "When you enter a job description, our AI optimizes your resume to align with the role, boosting your chances of getting hired!"
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FormsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(onboardingData[index]["image"]!, height: 250),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          onboardingData[index]["description"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: ExpandingDotsEffect(activeDotColor: Colors.black, dotColor: Colors.grey),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      IconButton(
                        onPressed: () {
                          _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        padding: EdgeInsets.all(10),
                      )
                    else
                      SizedBox(width: 48),
                    IconButton(
                      onPressed: _nextPage,
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      padding: EdgeInsets.all(10),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                        shape: WidgetStateProperty.all(CircleBorder()),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

