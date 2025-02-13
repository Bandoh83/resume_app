import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/screens/forms.dart';
import 'package:portfolio_app/screens/onboarding.dart';


void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
         theme: ThemeData(
        
        textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        //   colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: MaterialColor(Colors.white),
        //   ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'My Portfolio',
        home:  OnboardingScreen(),
    
      ),
    );
  }
}
