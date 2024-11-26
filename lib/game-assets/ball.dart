import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Adjust size as needed
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
