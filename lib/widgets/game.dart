import 'package:flutter/material.dart';
import 'package:flutter_tetris/main.dart';
import 'package:flutter_tetris/widgets/action_button.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE, NONE }
enum MoveDirection { LEFT, RIGHT, DOWN }

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
      print("Changing state: $performAction");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Container(
            width: WIDTH,
            height: HEIGHT,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButon(
              onClickedFunction: onActionButtonPressed,
              buttonIcon: Icon(Icons.arrow_left),
              nextAction: LastButtonPressed.LEFT,
            ),
            ActionButon(
              onClickedFunction: onActionButtonPressed,
              buttonIcon: Icon(Icons.arrow_right),
              nextAction: LastButtonPressed.RIGHT,
            ),
            ActionButon(
              onClickedFunction: onActionButtonPressed,
              buttonIcon: Icon(Icons.rotate_90_degrees_ccw),
              nextAction: LastButtonPressed.ROTATE,
            ),
          ],
        )
      ],
    );
  }
}
