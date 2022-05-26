import 'package:flutter/material.dart';
import 'package:snake_game/game.dart';


void main()=>runApp(snake());
class snake extends StatelessWidget {
  

 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snake Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: gamepage(),
    );
  }
}

