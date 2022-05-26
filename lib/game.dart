import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snake_game/piece.dart';
import 'piece.dart';
import 'dart:math';
import 'direction.dart';
import 'dart:async';
import 'control_panel.dart';
// import 'control_button.dart';

class gamepage extends StatefulWidget {
  @override
  State<gamepage> createState() => _gamepageState();
}

class _gamepageState extends State<gamepage> {
  int upperBoundX = 0, upperBoundY = 0, lowerBoundX = 0, lowerBoundY = 0;
  double screenWidth = 0.0, screenHeight = 0.0;
  int step = 30;
  // It is pixel that how much snake will move in one shift, also the size of one
  int length = 5;
  double speed = 1.0;
  int score = 0;
  // Timer timer=Timer.periodic(Duration(milliseconds:), (timer) { })
  Offset foodPosition = Offset(0, 0);
  piece food = piece(
    posX: 20,
    posY: 20,
    //  key: GlobalKey(),
    size: 50,
    color: Colors.brown,
    isAnimated: true,
  );

  Direction direction = Direction.left;
  Timer timer = Timer.periodic(Duration(), (timer) { });
  List<Offset> positions = []; // offset is like points x,y
  // fnction to get nearest ten digit   ex   908- 900

  void changeSpeed() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }

    timer = Timer.periodic(Duration(milliseconds: 200 ~/speed), (timer) {
      setState(() {});
    });
  }

  Widget getControls() {
    return ControlPanel(
      onTapped: (Direction newDirection) {
        direction = newDirection;
      },
      // key: GlobalKey(),
    );
  }

// return the direction for snake piece 0 when user tap on restart
  Direction getRandomDirection() {
    int x = Random().nextInt(4);
    return Direction.values[x];
  }

  void restart() {
    length = 5;
    score = 0;
    speed = 1;
    positions = [];
    direction = getRandomDirection();
    changeSpeed();
  }

  @override
  initState() {
    super.initState();
    restart();
  }

  int getNearestTens(int num) {
    int ans = 0;
    ans = (num ~/ step) * step; //  ~/ used for returning the complete value
    // eg n= 408 it will work as ...first divide the n with steps
    // therefor 20.4 now ..worlk as 20*20 and return 400
    if (ans == 0) ans += step;
    return ans;
  }

  Offset getRandomPosition() {
    // used for taking random position of snake inside the range of screen.

    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;
    Offset position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());

    return position;
  }

  // draw function is used for creating and modifying snake position

  void draw() async {
    if (positions.length == 0) {
      positions.add(getRandomPosition());
    }

    // here we succcesfully generated 5 position
    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }

    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];

      // this will change positions as
      // 4---->3
      // 3---->2
      // 2---->1
      // 1---->0
      // the zeroth position will be the direction one so it will be assign accordingly.
    }
    // here we have to create next position means snake head;
    positions[0] = await getNextPosition(positions[0]);
  }

  void showGameOverDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: Text(
              "Game Over",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Your game is over and tyour score is " + score.toString() + ".",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  
                  Navigator.of(context).pop();
                  restart();
                  print("restart");
                },
                child: Text(
                  "Restart",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }

  bool detectCollision(Offset position) {
    if (position.dx >= upperBoundX && direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX && direction == Direction.left) {
      return true;
    }
    if (position.dy >= upperBoundY && direction == Direction.down) {
      return true;
    }
    if (position.dy <= lowerBoundY && direction == Direction.up) {
      return true;
    }

    return false;
  }

  Future<Offset> getNextPosition(Offset position) async {
    Offset nextPosition =
        Offset(position.dx.toDouble(), position.dy.toDouble());
    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }
    if (timer != null && timer.isActive == true) {
      timer.cancel;
    }

    if (detectCollision(position) == true) {
      await Future.delayed(
          Duration(milliseconds: 200), () => showGameOverDialog());
    }

    return nextPosition;
  }

  void drawfood() {
    if (foodPosition == null) {
      foodPosition = getRandomPosition();
    }

    if (foodPosition == positions[0]) {
      length++;
      score += 5;
      speed += .25;
      foodPosition = getRandomPosition();
    }

    food = piece(
      posX: foodPosition.dx.toInt(),
      posY: foodPosition.dy.toInt(),
      // key: GlobalKey(),
      size: step,
      color: Colors.brown,
      isAnimated: true,
    );
  }

  List<piece> getPieces() {
    final pieces = <piece>[];
    draw();
    drawfood();
    for (var i = 0; i < length; i++) {
      if (i >= positions.length) {
        continue;
      }
      pieces.add(
        piece(
          // key: GlobalKey(),
          color: i % 2 == 0 ? Colors.red : Colors.green,
          posX: positions[i].dx.toInt(),
          posY: positions[i].dy.toInt(),
          size: step,
          isAnimated: false,
        ),
      );
    }

    pieces.add(
      piece(
        posX: positions[0].dx.toInt(),
        posY: positions[0].dy.toInt(),
        color: Colors.red,
        size: step,
        isAnimated: false,
        // key: GlobalKey(),
      ),
    );

    return pieces;
  }

  //for the score of game
  Widget getScore() {
    return Positioned(
      top: 80.0,
      right: 50.0,
      child: Text(
        'Score :' + score.toString(),
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    //media query fuction is used to find the height and width of screen.

    screenWidth = MediaQuery.of(context).size.width;
    lowerBoundY = step;
    lowerBoundX = step;

    // we define the lower and upper as step , because below step we will have boundary condtion , collision condn

    upperBoundY = getNearestTens(screenHeight.toInt() - step);

    // to avoid width like 906, 605  we will use another function

    upperBoundX = getNearestTens(screenWidth.toInt() - step);
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Stack(
          children: [
            Stack(
              children: getPieces(),
            ),
            getControls(),
            food,
            getScore(),
          ],
        ),
      ),
    );
  }
}
