import 'package:flutter/material.dart';

class GameManager {
  final context;
  double _paddleX;
  Offset _ballPosition = const Offset(100, 100);

  GameManager(this._paddleX, this.context);

  double get paddleX => _paddleX;
  double get ballX => _ballPosition.dx;
  double get ballY => _ballPosition.dy;

  void updatePaddlePosition(double newPaddleX) {
    _paddleX = newPaddleX;
    checkForBallXPaddleCollision();
  }

  void moveBall(double ballXIncrement, double ballYIncrement) {
    _ballPosition = _ballPosition.translate(ballXIncrement, ballYIncrement);
    checkForBallXPaddleCollision();
  }

  set ballPosition(Offset newPosition) {
    _ballPosition = newPosition;
  }

  Offset get ballPosition => _ballPosition;

  void checkForBallXPaddleCollision() {
    if ((ballX >= paddleX - 10 && ballX <= paddleX + 10) &&
        (ballY >= MediaQuery.of(context).size.height - 40)) {
      // Adjust these values based on your paddle size and position
      print('collision detected');
      // Add collision response logic here
    }
  }
}
