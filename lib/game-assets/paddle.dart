import 'package:flutter/material.dart';

class Paddle extends StatefulWidget {
  Paddle({super.key, this.alignmentX = 0.0});
  double alignmentX;

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  double Xalignment = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Convert drag position into alignment value between -1.0 and 1.0
          Xalignment = (details.globalPosition.dx / screenWidth) * 2 - 1;
          print('X alignment is ' + Xalignment.toString());
        });
      },
      child: Align(
        alignment: Alignment(Xalignment, 1.0),
        child: Container(
          height: screenHeight * .04,
          width: screenWidth * 0.2,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }
}
