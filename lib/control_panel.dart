import 'package:flutter/cupertino.dart';
import 'package:snake_game/control_button.dart';
import 'direction.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
   void Function(Direction direction) onTapped;
   ControlPanel({ Key? key, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 50.0,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                controlButton(
                  onPressed: () {
                    print('left');
                    onTapped(Direction.left);
                  },
                  icon: Icon(Icons.arrow_left),
                  // key: GlobalKey(),
                )
              ],
            ),
          ),
          Expanded(child: Column(
            children: [
                controlButton(
                  onPressed: () {
                    print('UP');
                    onTapped(Direction.up);
                  },
                  icon: Icon(Icons.arrow_drop_up),
                  // key: GlobalKey(),
                ),
                SizedBox(
                  height: 70.0,
                ),
                controlButton(
                  onPressed: () {
                    print('down');
                    onTapped(Direction.down);
                  },
                  icon: Icon(Icons.arrow_drop_down),
                  // key: GlobalKey(),
                )
            ],
          )),
          Expanded(
            child: Row(
              children: [
                
                controlButton(
                  onPressed: () {
                    print('right');
                    onTapped(Direction.right);
                  },
                  icon: Icon(Icons.arrow_right),
                  // key: GlobalKey(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
