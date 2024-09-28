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
    gameManager = GameManager(0.0, context);
  }

  void _updatePaddlePosition(double newPosition) {
    setState(() {
      gameManager.updatePaddlePosition(newPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
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
              Positioned(
                top: 20,
                left: 20,
                child: ElevatedButton(
                  onPressed: () {
                    if (gameManager.isGameRunning) {
                      gameManager.stopGame();
                    } else {
                      gameManager.startGame();
                    }
                    setState(() {});
                  },
                  child: Text(
                      gameManager.isGameRunning ? 'Stop Game' : 'Start Game'),
                ),
              ),
              // Add other game elements here (bricks, score, etc.)
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    gameManager.stopGame();
    super.dispose();
  }
}
