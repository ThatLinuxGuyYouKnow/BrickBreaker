import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final Function(double) onPaddlePositionChanged;

  const Paddle({Key? key, required this.onPaddlePositionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        onPaddlePositionChanged(details.globalPosition.dx);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.016,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
