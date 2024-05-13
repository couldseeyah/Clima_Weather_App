import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget child;
  const ReusableCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromARGB(255, 21, 147, 164).withOpacity(0.25),
      ),
      child: child,
    );
  }
}