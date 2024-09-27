import 'package:flutter/material.dart';

class GameManager {
  final double paddleX;
  Offset _ballPosition = const Offset(100, 100); // Ball position

  // Constructor initializes paddleX and ball position
  GameManager(this.paddleX);

  // Getters to access ballX and ballY
  double get ballX => _ballPosition.dx;
  double get ballY => _ballPosition.dy;

  void moveBall(double ballXIncrement, double ballYIncrement) {
    _ballPosition = _ballPosition.translate(ballXIncrement, ballYIncrement);
  }

  // Setter to manually update the ball's position
  set ballPosition(Offset newPosition) {
    _ballPosition = newPosition;
  }

  // Getter to access the full ball position as an Offset
  Offset get ballPosition => _ballPosition;

  checkForBallXPaddleColission() {}
}
