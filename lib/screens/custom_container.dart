import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;

  const CustomContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFF5F5F5),
      ),
      child: child,
    );
  }
}