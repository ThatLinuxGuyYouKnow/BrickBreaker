import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final double initialAlignment;
  final Function(double) onChanged;
  final Function(Offset) onPositionChanged;

  const Paddle(
      {Key? key,
      required this.initialAlignment,
      required this.onChanged,
      required this.onPositionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Convert alignment into actual position in pixels
        final paddleX = (initialAlignment + 1) / 2 * screenWidth -
            40; // 40 is half paddle width
        final paddleY = constraints.maxHeight * 0.9;

        // Ensure paddle position update happens after build phase
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onPositionChanged(Offset(paddleX, paddleY));
        });

        return Align(
          alignment: Alignment(initialAlignment, 0.9),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
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
      },
    );
  }
}
