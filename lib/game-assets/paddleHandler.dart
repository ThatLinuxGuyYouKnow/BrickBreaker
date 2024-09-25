import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:flutter/material.dart';

class PaddleHandler extends StatefulWidget {
  @override
  State<PaddleHandler> createState() => _PaddleHandlerState();
}

class _PaddleHandlerState extends State<PaddleHandler> {
  Widget build(BuildContext context) {
    double paddlePositon = 0.0;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        print('getting hit');
        setState(() {
          details.localPosition.dx;
        });
      },
      child: Row(
        children: [
          Container(alignment: Alignment(paddlePositon, 100.0), child: Paddle())
        ],
      ),
    );
  }
}
