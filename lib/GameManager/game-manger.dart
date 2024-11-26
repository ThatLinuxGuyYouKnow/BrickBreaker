import 'package:flutter/material.dart';
import 'dart:async';
import 'package:brickbreaker/GameManager/gameStateEnum.dart';

class GameManager {
  final BuildContext context;
  double _paddleX; // X position of the paddle
  Offset _ballPosition =
      const Offset(100, 100); // Initial position of the ball (x, y)
  double _ballSpeedX = 3.0; // Horizontal speed of the ball
  double _ballSpeedY =
      -3.0; // Vertical speed of the ball (negative means going upwards)
  GameState _gameState = GameState.hasNotStarted;
  Timer?
      _gameLoop; // Timer that updates the game every 16 milliseconds (60 FPS)
  VoidCallback? onUpdate; // Callback to update the game UI
  bool _isDisposed = false; // Flag to check if the game has been disposed

  GameManager(this._paddleX, this.context);

  double get paddleX => _paddleX;
  double get ballX => _ballPosition.dx;
  double get ballY => _ballPosition.dy;
  GameState get gameState => _gameState;

  // Update paddle position based on user input (from drag)
  void updatePaddlePosition(double newPaddleX) {
    _paddleX = newPaddleX;
    checkForBallXPaddleCollision(); // Check if the ball collides with the paddle after the update
  }

  // Start the game by resetting the ball and starting the game loop
  void startGame() {
    if (_gameState != GameState.hasStarted && !_isDisposed) {
      _gameState = GameState.hasStarted;
      _resetBallPosition(); // Reset the ball to the center of the screen
      // Start the game loop: update the game state every 16ms (roughly 60 FPS)
      _gameLoop =
          Timer.periodic(const Duration(milliseconds: 16), (_) => _update());
      _safeUpdate(); // Notify UI of changes
    }
  }

  // Stop the game, cancel the game loop, and notify the UI
  void stopGame() {
    _gameState = GameState.hasEnded;
    _gameLoop?.cancel();
    _safeUpdate();
  }

  // The main game loop that runs continuously
  void _update() {
    if (_isDisposed) {
      _gameLoop?.cancel(); // If disposed, stop the game loop
      return;
    }
    moveBall(_ballSpeedX, _ballSpeedY); // Move the ball based on its speed
    checkWallCollisions(); // Check for collisions with the walls
    checkForBallXPaddleCollision(); // Check for collisions with the paddle
    _safeUpdate(); // Notify UI of changes
  }

  // Function to move the ball by a given amount in both X and Y directions
  void moveBall(double ballXIncrement, double ballYIncrement) {
    // `translate` shifts the ball position by the given increments
    _ballPosition = _ballPosition.translate(ballXIncrement, ballYIncrement);
  }

  // Reset the ball to the center of the screen
  void _resetBallPosition() {
    final size = MediaQuery.of(context).size; // Get screen size
    _ballPosition =
        Offset(size.width / 2, size.height / 2); // Place ball in the center
  }

  // Check if the ball hits any of the walls (left, right, top, or bottom)
  void checkWallCollisions() {
    final size = MediaQuery.of(context).size; // Get screen size

    // If the ball hits the left or right wall
    if (_ballPosition.dx <= 0 || _ballPosition.dx >= size.width) {
      _ballSpeedX = -_ballSpeedX; // Reverse horizontal direction
    }

    // If the ball hits the top wall
    if (_ballPosition.dy <= 0) {
      _ballSpeedY = -_ballSpeedY; // Reverse vertical direction
    }

    // If the ball hits the bottom of the screen (lose condition)
    if (_ballPosition.dy >= size.height) {
      stopGame(); // End the game
    }
  }

  // Check for collisions between the ball and the paddle
  void checkForBallXPaddleCollision() {
    final paddleWidth = MediaQuery.of(context).size.width *
        0.2; // Paddle width as a fraction of screen width
    final paddleHeight = MediaQuery.of(context).size.height *
        0.03; // Paddle height as a fraction of screen height
    final paddleTop = MediaQuery.of(context).size.height -
        60 -
        paddleHeight; // Distance from the top of the screen to the top of the paddle

    // Check if the ball is within the vertical bounds of the paddle
    if (_ballPosition.dy >= paddleTop &&
        _ballPosition.dy <= paddleTop + paddleHeight &&
        _ballPosition.dx >=
            _paddleX && // Check if the ball's X position is within the paddle's X range
        _ballPosition.dx <= _paddleX + paddleWidth) {
      // If all the conditions are met, it means the ball has hit the paddle

      _ballSpeedY = -_ballSpeedY; // Reverse vertical direction

      // Calculate how far from the center of the paddle the ball hit
      // Adjust the horizontal speed of the ball based on this offset, adding variability to the ball's bounce
      _ballSpeedX += (_ballPosition.dx - (_paddleX + paddleWidth / 2)) /
          (paddleWidth / 2) *
          2;

      // Limit the horizontal speed to avoid the ball moving too fast
      _ballSpeedX = _ballSpeedX.clamp(-8, 8);
    }
  }

  // Set a callback function that is called whenever the game updates (e.g., to refresh the UI)
  void setUpdateCallback(VoidCallback callback) {
    onUpdate = callback;
  }

  // Safely call the update callback to notify the UI
  void _safeUpdate() {
    if (!_isDisposed) {
      onUpdate?.call();
    }
  }

  // Dispose of the game resources and stop the game loop
  void dispose() {
    _isDisposed = true;
    _gameLoop?.cancel();
  }
}
