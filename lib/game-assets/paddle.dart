import 'package:flutter/material.dart';

class Paddle extends StatefulWidget {
  final Function(double) onPaddlePositionChanged;

  const Paddle({super.key, required this.onPaddlePositionChanged});

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  double paddleX = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onHorizontalDragUpdate: (details) => setState(() {
        // Update paddle position
        paddleX = details.globalPosition.dx;

        // Notify the parent widget or external class
        widget.onPaddlePositionChanged(paddleX);
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
