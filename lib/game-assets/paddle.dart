import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  Paddle({super.key, this.alignmentX = 1.0});
  double alignmentX;
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment(alignmentX, 1.0),
      height: screenHeight * .04,
      width: screenWidth * 0.2,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(2)),
    );
  }
}
