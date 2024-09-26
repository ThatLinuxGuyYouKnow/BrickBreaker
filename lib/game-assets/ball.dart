import 'dart:async';
import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  final Function(Offset) onUpdate;
  final Offset velocity;
  final Function(Offset) onVelocityChange;
  static const double ballSize = 20.0;

  const Ball(
      {Key? key,
      required this.onUpdate,
      required this.velocity,
      required this.onVelocityChange})
      : super(key: key);

  @override
  _BallState createState() => _BallState(); // Added this method
}

class _BallState extends State<Ball> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = const Offset(0, 0);
    Timer.periodic(const Duration(milliseconds: 16), _updateBall);
  }

  void _updateBall(Timer timer) {
    setState(() {
      position += widget.velocity;
      widget.onUpdate(position);

      // Check for wall collisions
      if (position.dx <= 0 ||
          position.dx >= MediaQuery.of(context).size.width - Ball.ballSize) {
        widget
            .onVelocityChange(Offset(-widget.velocity.dx, widget.velocity.dy));
      }
      if (position.dy <= 0 ||
          position.dy >= MediaQuery.of(context).size.height - Ball.ballSize) {
        widget
            .onVelocityChange(Offset(widget.velocity.dx, -widget.velocity.dy));
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
