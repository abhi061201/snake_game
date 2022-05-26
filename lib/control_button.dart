import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class controlButton extends StatelessWidget {
   Function onPressed;
  final Icon icon;
   controlButton(
      { Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: 80.0,
        height: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 10,
            onPressed:() {onPressed();},
            child: this.icon,
          ),
        ),
      ),
    );
  }
}
