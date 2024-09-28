import 'package:brickbreaker/GameManager/game-manger.dart';
import 'package:brickbreaker/mainGameScreen.dart';
import 'package:flutter/material.dart';

class GameStateManager extends StatelessWidget {
  GameStateManager({super.key});

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.white,
          child: Center(
              child: Column(
            children: [
              Text('S T A R T'),
              SizedBox(
                height: screenHeight * .002,
              ),
              Text('G A M E')
            ],
          )),
        ),
        BrickBreakerGame()
      ],
    );
  }
}
