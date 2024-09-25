import 'package:brickbreaker/game-assets/ball.dart';
import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({Key? key}) : super(key: key);

  @override
  State<BrickBreakerGame> createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late Offset ballPosition;
  double paddleX = 0.0;

  @override
  void initState() {
    super.initState();
    ballPosition = const Offset(0, 0);
  }

  void _updateBallPosition(Offset position) {
    setState(() {
      ballPosition = position;
    });
    _checkCollision();
  }

  void _checkCollision() {
    final paddleTop = MediaQuery.of(context).size.height -
        60; // Adjust based on your paddle's position
    final paddleLeft = (MediaQuery.of(context).size.width +
                paddleX * MediaQuery.of(context).size.width) /
            2 -
        40; // Adjust based on your paddle's width
    final paddleRight = paddleLeft + 80; // Assuming paddle width is 80

    if (ballPosition.dy + Ball.ballSize >= paddleTop &&
        ballPosition.dy + Ball.ballSize <= paddleTop + 20 &&
        ballPosition.dx + Ball.ballSize >= paddleLeft &&
        ballPosition.dx <= paddleRight) {
      // Collision detected!
      print('Collision detected!');
      // Here you would typically change the ball's direction
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Ball(onUpdate: _updateBallPosition),
          Paddle(
            initialAlignment: paddleX,
            onChanged: (x) => setState(() => paddleX = x),
          ),
        ],
      ),
    );
  }
}
