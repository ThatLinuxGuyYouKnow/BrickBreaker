import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final double initialAlignment;
  final Function(double) onChanged;

  const Paddle(
      {Key? key, required this.initialAlignment, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(initialAlignment, 0.9),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final newAlignment =
              (details.globalPosition.dx / screenWidth) * 2 - 1;
          onChanged(newAlignment.clamp(-1.0, 1.0));
        },
        child: Container(
          height: 20,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
