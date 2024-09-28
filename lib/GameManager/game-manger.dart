import 'package:flutter/material.dart';
import 'dart:async';

class GameManager {
  final BuildContext context;
  double _paddleX;
  Offset _ballPosition = const Offset(100, 100);
  double _ballSpeedX = 3.0;
  double _ballSpeedY = -3.0;
  bool _isGameRunning = false;
  Timer? _gameLoop;

  GameManager(this._paddleX, this.context);

  double get paddleX => _paddleX;
  double get ballX => _ballPosition.dx;
  double get ballY => _ballPosition.dy;
  bool get isGameRunning => _isGameRunning;

  void updatePaddlePosition(double newPaddleX) {
    _paddleX = newPaddleX;
    checkForBallXPaddleCollision();
  }

  void startGame() {
    if (!_isGameRunning) {
      _isGameRunning = true;
      _resetBallPosition();
      _gameLoop = Timer.periodic(Duration(milliseconds: 16), (_) => _update());
    }
  }

  void stopGame() {
    _isGameRunning = false;
    _gameLoop?.cancel();
  }

  void _update() {
    moveBall(_ballSpeedX, _ballSpeedY);
    checkWallCollisions();
    checkForBallXPaddleCollision();
    // Add any other game logic here (e.g., brick collisions, scoring)
  }

  void moveBall(double ballXIncrement, double ballYIncrement) {
    _ballPosition = _ballPosition.translate(ballXIncrement, ballYIncrement);
  }

  void _resetBallPosition() {
    final size = MediaQuery.of(context).size;
    _ballPosition = Offset(size.width / 2, size.height / 2);
  }

  void checkWallCollisions() {
    final size = MediaQuery.of(context).size;
    if (_ballPosition.dx <= 0 || _ballPosition.dx >= size.width) {
      _ballSpeedX = -_ballSpeedX;
    }
    if (_ballPosition.dy <= 0) {
      _ballSpeedY = -_ballSpeedY;
    }
    if (_ballPosition.dy >= size.height) {
      // Ball hit the bottom - game over condition
      stopGame();
      // Implement game over logic here
    }
  }

  void checkForBallXPaddleCollision() {
    final paddleWidth = MediaQuery.of(context).size.width *
        0.2; // Adjust based on your paddle size
    final paddleHeight = MediaQuery.of(context).size.height *
        0.03; // Adjust based on your paddle size
    final paddleTop = MediaQuery.of(context).size.height - 20 - paddleHeight;

    if (_ballPosition.dy >= paddleTop &&
        _ballPosition.dy <= paddleTop + paddleHeight &&
        _ballPosition.dx >= _paddleX &&
        _ballPosition.dx <= _paddleX + paddleWidth) {
      _ballSpeedY = -_ballSpeedY;
      // Optionally, adjust X speed based on where the ball hit the paddle
      _ballSpeedX += (_ballPosition.dx - (_paddleX + paddleWidth / 2)) /
          (paddleWidth / 2) *
          2;
      _ballSpeedX = _ballSpeedX.clamp(-8, 8); // Limit max horizontal speed
    }
  }

  set ballPosition(Offset newPosition) {
    _ballPosition = newPosition;
  }

  Offset get ballPosition => _ballPosition;
}
