import 'package:flutter/material.dart';

class Paddle extends StatefulWidget {
  const Paddle({super.key});

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddleX = 0.0;
    return GestureDetector(
      onHorizontalDragUpdate: (details) => setState(() {
        paddleX = details.globalPosition.dx;
      }),
      child: Positioned(
        left: paddleX,
        bottom: 20,
        child: Container(
          alignment: Alignment(paddleX, 1),
          width: screenWidth * 0.2,
          height: screenHeight * 0.03,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
