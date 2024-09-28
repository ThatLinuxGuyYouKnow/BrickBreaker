import 'package:brickbreaker/GameManager/game-manger.dart';
import 'package:brickbreaker/game-assets/ball.dart';
import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:flutter/material.dart';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({Key? key}) : super(key: key);

  @override
  _BrickBreakerGameState createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late GameManager gameManager;

  @override
  void initState() {
    super.initState();
    gameManager =
        GameManager(0.0, context); // Initialize with default paddle position
  }

  void _updatePaddlePosition(double newPosition) {
    setState(() {
      gameManager.updatePaddlePosition(newPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: gameManager.ballX,
              top: gameManager.ballY,
              child: Ball(ballX: gameManager.ballX, ballY: gameManager.ballY),
            ),
            Positioned(
              left: gameManager.paddleX,
              bottom: 20,
              child: Paddle(onPaddlePositionChanged: _updatePaddlePosition),
            ),
            // Add other game elements here (bricks, score, etc.)
          ],
        );
      },
    );
  }
}
