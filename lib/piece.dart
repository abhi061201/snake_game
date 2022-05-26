import 'package:flutter/material.dart';

class piece extends StatefulWidget {
  final int posX, posY, size;
  final Color color;
  final bool isAnimated;

  // piece(Color color, int posX, int posY, int size, Key key) : super(key: key) {
  //   this.color = color;
  //   this.posX = posX;
  //   this.posY = posY;
  //   this.size = size;
  // }
  piece({
    Key? key,
    required this.color,
    required this.posX,
    required this.posY,
    required this.size,
    required this.isAnimated,
  }) : super(key: key);
  State<piece> createState() => _pieceState();
}

class _pieceState extends State<piece> with SingleTickerProviderStateMixin {
 
        // AnimationController _animationController=AnimationController(vsync: this);
  @override
  void initState() {
    super.initState();
    
          // _animationController = AnimationController(
          //     lowerBound: 0.25,
          //     upperBound: 1.0,
          //     duration: Duration(milliseconds: 1000),
          //     vsync: this,
          // );
          // _animationController.addStatusListener(
          //   (status) {
          //     //if game copleted we start the game animation again
          //     if (status == AnimationStatus.completed) {
          //       _animationController.reset();
          //     }

          //     //dismissed: Game is suddenly stopped user back button
          //     //it should start from that position
          //     else if (status == AnimationStatus.dismissed) {
          //       _animationController.forward();
    //       //     }
    //   },
    // );
    // _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // used for overlap one thing to other, as snake ad button overlap in game
      top: widget.posY.toDouble(),
      left: widget.posX.toDouble(),
      child: Opacity(
        opacity:1,
        child: Container(
          width: widget.size.toDouble(),
          height: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(width: 2.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
