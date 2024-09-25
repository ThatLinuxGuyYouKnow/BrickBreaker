import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:flutter/material.dart';

class PaddleHandler extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [Paddle()],
      ),
    );
  }
}
