import 'package:flutter/material.dart';

class Paddle extends StatefulWidget {
  Paddle({super.key, this.alignmentX = 1.0});
  double alignmentX;

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  Widget build(BuildContext context) {
    double Xalignment = 100.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        Xalignment = details.globalPosition.dx;
        print('x alignmrnt is ' + Xalignment.toString());
      },
      child: Container(
        alignment: Alignment(Xalignment, 1.0),
        height: screenHeight * .04,
        width: screenWidth * 0.2,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(2)),
      ),
    );
  }
}
