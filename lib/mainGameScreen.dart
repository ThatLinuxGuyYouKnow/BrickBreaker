import 'package:flutter/material.dart';
import 'dart:async';
import 'package:brickbreaker/game-assets/ball.dart';
import 'package:brickbreaker/game-assets/paddle.dart';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({Key? key}) : super(key: key);

  @override
  State<BrickBreakerGame> createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late Offset ballPosition;
  late Offset ballVelocity;
  double paddleX = 0.0;
  Offset paddlePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    ballPosition = const Offset(0, 0);
    ballVelocity = const Offset(3, 3); // Initial velocity
  }

  void _updateBallPosition(Offset position) {
    setState(() {
      ballPosition = position;
    });
    _checkCollision();
  }

  void _updatePaddlePosition(Offset position) {
    setState(() {
      paddlePosition = position;
    });
  }

  void _checkCollision() {
    final paddleRect = Rect.fromLTWH(
        paddlePosition.dx,
        paddlePosition.dy,
        80, // Paddle width
        20 // Paddle height
        );

    final ballRect = Rect.fromLTWH(
        ballPosition.dx, ballPosition.dy, Ball.ballSize, Ball.ballSize);

    if (ballRect.overlaps(paddleRect)) {
      // Collision detected!
      print('Collision detected!');
      _changeBallDirection(paddleRect);
    }
  }

  void _changeBallDirection(Rect paddleRect) {
    // Reverse the vertical direction
    ballVelocity = Offset(ballVelocity.dx, -ballVelocity.dy);

    // Add some horizontal variation based on where the ball hit the paddle
    final hitPoint = (ballPosition.dx - paddleRect.left) / paddleRect.width;
    final angleChange = (hitPoint - 0.5) * 2; // -1 to 1
    ballVelocity = Offset(ballVelocity.dx + angleChange, ballVelocity.dy);

    // Normalize the velocity to maintain constant speed
    final speed = ballVelocity.distance;
    ballVelocity = ballVelocity / ballVelocity.distance * speed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Ball(
            onUpdate: _updateBallPosition,
            velocity: ballVelocity,
            onVelocityChange: (newVelocity) => ballVelocity = newVelocity,
          ),
          Paddle(
            initialAlignment: paddleX,
            onChanged: (x) => setState(() => paddleX = x),
            onPositionChanged: _updatePaddlePosition,
          ),
        ],
      ),
    );
  }
}
