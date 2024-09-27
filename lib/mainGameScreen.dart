import 'package:brickbreaker/GameManager/game-manger.dart';
import 'package:brickbreaker/game-assets/ball.dart';
import 'package:brickbreaker/game-assets/paddle.dart';
import 'package:flutter/material.dart';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({Key? key}) : super(key: key);

  @override
  State<BrickBreakerGame> createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late GameManager gameManager;
  Offset ballPosition = const Offset(100, 100);
  double paddleX = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      gameManager = GameManager(
        updateBallPosition: (position) =>
            setState(() => ballPosition = position),
        updatePaddlePosition: (x) => setState(() => paddleX = x),
        screenSize: size,
      );
      gameManager.startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (gameManager != null) {
            final screenWidth = MediaQuery.of(context).size.width;
            final newX = details.globalPosition.dx - (screenWidth * 0.1);
            gameManager
                .updatePaddle(newX.clamp(0, screenWidth - (screenWidth * 0.2)));
          }
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Ball(ballX: ballPosition.dx, ballY: ballPosition.dy),
              Paddle(paddleX: paddleX),
            ],
          ),
        ),
      ),
    );
  }
}
