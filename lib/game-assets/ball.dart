import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;

  const Ball({Key? key, required this.ballX, required this.ballY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: ballX,
      top: ballY,
      child: Container(
        width: screenWidth * 0.05, // Increased size for visibility
        height: screenHeight * 0.05,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
