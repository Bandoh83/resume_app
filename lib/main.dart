import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio_app/screens/forms.dart';

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
          colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
  0xFF0B2760,
  <int, Color>{
    50: Color(0xFF401C1C).withOpacity(0.1),
    100: Color(0xFF401C1C).withOpacity(0.2),
    200: Color(0xFF401C1C).withOpacity(0.3),
    300: Color(0xFF401C1C).withOpacity(0.4),
    400: Color(0xFF401C1C).withOpacity(0.5),
    500: Color(0xFF401C1C).withOpacity(0.6),
    600: Color(0xFF401C1C).withOpacity(0.7),
    700: Color(0xFF401C1C).withOpacity(0.8),
    800: Color(0xFF401C1C).withOpacity(0.9),
    900: Color(0xFF401C1C).withOpacity(1.0),
  },
),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'My Portfolio',
        home:  FormsScreen(),
      ),
    );
  }
}
