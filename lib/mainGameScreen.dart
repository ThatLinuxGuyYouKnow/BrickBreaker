import 'package:flutter/material.dart';
import 'package:brickbreaker/GameManager/game-manger.dart';
import 'package:brickbreaker/game-assets/ball.dart';
import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:brickbreaker/GameManager/gameStateEnum.dart';

class BrickBreakerGame extends StatefulWidget {
  final GameManager gameManager;
  const BrickBreakerGame({Key? key, required this.gameManager})
      : super(key: key);

  @override
  _BrickBreakerGameState createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late GameManager gameManager;

  @override
  void initState() {
    super.initState();
    gameManager = widget.gameManager;
    gameManager.setUpdateCallback(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _updatePaddlePosition(double newPosition) {
    gameManager.updatePaddlePosition(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: gameManager.ballX,
          top: gameManager.ballY,
          child: Ball(),
        ),
        Positioned(
          left: gameManager.paddleX,
          bottom: 20,
          child: Paddle(onPaddlePositionChanged: _updatePaddlePosition),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: ElevatedButton(
            onPressed: () {
              if (gameManager.gameState == GameState.hasStarted) {
                gameManager.stopGame();
              } else {
                gameManager.startGame();
              }
            },
            child: Text(gameManager.gameState == GameState.hasStarted
                ? 'Stop Game'
                : 'Start Game'),
          ),
        ),
        // Add other game elements here (bricks, score, etc.)
      ],
    );
  }

  @override
  void dispose() {
    gameManager.dispose();
    super.dispose();
  }
}
