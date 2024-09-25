import 'dart:async';

import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  final Function(Offset) onUpdate;
  static const double ballSize = 20.0; // Moved here

  const Ball({Key? key, required this.onUpdate}) : super(key: key);

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  late Offset position;
  late Offset velocity;

  @override
  void initState() {
    super.initState();
    position = const Offset(0, 0);
    velocity = const Offset(3, 3);
    Timer.periodic(const Duration(milliseconds: 16), _updateBall);
  }

  void _updateBall(Timer timer) {
    setState(() {
      position += velocity;
      widget.onUpdate(position);

      // Check for wall collisions
      if (position.dx <= 0 ||
          position.dx >= MediaQuery.of(context).size.width - Ball.ballSize) {
        velocity = Offset(-velocity.dx, velocity.dy);
      }
      if (position.dy <= 0 ||
          position.dy >= MediaQuery.of(context).size.height - Ball.ballSize) {
        velocity = Offset(velocity.dx, -velocity.dy);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: Ball.ballSize,
        height: Ball.ballSize,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
