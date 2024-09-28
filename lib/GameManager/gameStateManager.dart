import 'package:flutter/material.dart';
import 'package:brickbreaker/GameManager/game-manger.dart';
import 'package:brickbreaker/GameManager/gameStateEnum.dart';
import 'package:brickbreaker/mainGameScreen.dart';

class GameStateManager extends StatefulWidget {
  const GameStateManager({Key? key}) : super(key: key);

  @override
  _GameStateManagerState createState() => _GameStateManagerState();
}

class _GameStateManagerState extends State<GameStateManager> {
  late GameManager gameManager;

  @override
  void initState() {
    super.initState();
    gameManager = GameManager(0.0, context);
    gameManager.setUpdateCallback(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            child: Center(
              child: gameManager.gameState == GameState.hasEnded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('G A M E'),
                        SizedBox(height: screenHeight * .002),
                        Text('O V E R'),
                        ElevatedButton(
                          onPressed: () {
                            gameManager.startGame();
                          },
                          child: Text('Restart'),
                        ),
                      ],
                    )
                  : gameManager.gameState == GameState.hasNotStarted
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('S T A R T'),
                            SizedBox(height: screenHeight * .002),
                            Text('G A M E'),
                            ElevatedButton(
                              onPressed: () {
                                gameManager.startGame();
                              },
                              child: Text('Start'),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
            ),
          ),
          if (gameManager.gameState == GameState.hasStarted) BrickBreakerGame(),
        ],
      ),
    );
  }
}
