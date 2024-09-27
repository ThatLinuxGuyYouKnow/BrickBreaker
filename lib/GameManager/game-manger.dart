import 'dart:async';
import 'package:flutter/material.dart';

class GameManager {
  final Function(Offset) updateBallPosition;
  final Function(double) updatePaddlePosition;
  final Size screenSize;

  Offset ballPosition;
  Offset ballVelocity;
  double paddleX;
  double paddleWidth;
  double paddleHeight;

  late Timer gameLoop;

  GameManager({
    required this.updateBallPosition,
    required this.updatePaddlePosition,
    required this.screenSize,
    this.ballPosition = const Offset(100, 100),
    this.ballVelocity = const Offset(3, 3),
    this.paddleX = 0,
    this.paddleWidth = 80,
    this.paddleHeight = 20,
  });

  void startGame() {
    gameLoop = Timer.periodic(const Duration(milliseconds: 16), _update);
  }

  void _update(Timer timer) {
    _moveBall();
    _checkWallCollision();
    _checkPaddleCollision();
    updateBallPosition(ballPosition);
  }

  void _moveBall() {
    ballPosition += ballVelocity;
  }

  void _checkWallCollision() {
    if (ballPosition.dx <= 0 || ballPosition.dx >= screenSize.width - 20) {
      ballVelocity = Offset(-ballVelocity.dx, ballVelocity.dy);
    }
    if (ballPosition.dy <= 0) {
      ballVelocity = Offset(ballVelocity.dx, -ballVelocity.dy);
    }
    if (ballPosition.dy >= screenSize.height - 20) {
      // Game over logic here
      gameLoop.cancel();
      print('Game Over!');
    }
  }

  void _checkPaddleCollision() {
    final paddleRect = Rect.fromLTWH(
      paddleX,
      screenSize.height - paddleHeight - 20,
      paddleWidth,
      paddleHeight,
    );

    final ballRect = Rect.fromLTWH(
      ballPosition.dx,
      ballPosition.dy,
      20,
      20,
    );

    if (ballRect.overlaps(paddleRect)) {
      ballVelocity = Offset(ballVelocity.dx, -ballVelocity.dy.abs());

      final hitPoint =
          (ballPosition.dx + 10 - paddleRect.left) / paddleRect.width;
      final angleChange = (hitPoint - 0.5) * 2; // -1 to 1
      ballVelocity = Offset(ballVelocity.dx + angleChange, ballVelocity.dy);

      final speed = 6.0; // Constant speed
      ballVelocity = ballVelocity / ballVelocity.distance * speed;
    }
  }

  void updatePaddle(double newX) {
    paddleX = newX;
    updatePaddlePosition(paddleX);
  }
}
