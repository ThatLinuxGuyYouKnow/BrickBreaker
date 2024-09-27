import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final double paddleX;

  const Paddle({Key? key, required this.paddleX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: paddleX,
      bottom: 20,
      child: Container(
        width: screenWidth * 0.2,
        height: screenHeight * 0.03,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
