import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/bloc/alive_points.dart';
import 'package:flutter_tetris/bloc/block.dart';
import 'package:flutter_tetris/main.dart';
import 'package:flutter_tetris/widgets/action_button.dart';
import 'package:flutter_tetris/helpert.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDirection { LEFT, RIGHT, DOWN }

const double WIDTH = 200;
const double HEIGHT = 400;

const int BOARD_WIDTH = 10; //la largeur du plateau de jeu // 10 points
const int BOARD_HEIGHT = 20; //la hauteur du plateau de jeu //20 points

const double POINT_SIZE = 20; //la taille en pixel d'un point

const int GAME_SPEED =
    400; //vitesse à laquelle descend les blocks (en milliseconds)
Timer timer;

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Block currentBlock;
  LastButtonPressed performAction = LastButtonPressed.NONE;
  //liste des block qu'on a déjà positionner sur notre plateau de jeu
  List<AlivePoint> alivePoints = List<AlivePoint>();
  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
      print("Changing state: $performAction");
    });
  }

//on veut que la methode startGame soit appélé une seule fois c'est pour ça
//qu'on la met dans le initSate. Si on le met dans le build, elle sera
//appelée à chaque rebuild
  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    //ce timer prendre 400 milliseconds de pause puis exécute le callback
    //ici la fonction onTimeTick
    //et comme on veut ça récommence cette boucle encore et encore jusqu'à une
    //condition d'arrêt, on utilise Timer.periodic()
    timer = new Timer.periodic(
      new Duration(milliseconds: GAME_SPEED),
      onTimeTick,
    );
  }

  void saveOldBlock() {
    currentBlock.points.forEach((point) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock.color);
      setState(() {
        alivePoints.add(newPoint);
      });
    });
  }

  bool isAboveOldBlock() {
    //on verifie si un des points de tetris block est tout en bas (y == BOARD_HEIGHT)
    //bool canGoDown = true;
    bool retVal = false;
    alivePoints.forEach((oldPoint) {});

    return retVal;

    // bool canGoDown = true;
    // currentBlock.points.forEach((point) {
    //   alivePoints.forEach((element) {
    //     if (element.y == point.y + 1) {
    //       canGoDown = false;
    //     }
    //   });
    // });

    // return canGoDown;
  }

  //on descend le block toutes les 400 milliseconds
  void onTimeTick(Timer timer) {
    if (currentBlock == null) {
      return;
    }
    //on verifie si le tetris block a touché le board du bas
    if (currentBlock.isAtBottom()) {
      //on sauvegarde le block en bas pour qu'il ne disparaisse pas
      saveOldBlock();
      //on créé un nouveau block qui va descendre
      print("Spawning new random block...");
      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock.move(MoveDirection.DOWN);
      });
      checkForUserInput();
    }
  }

  void checkForUserInput() {
    if (performAction != LastButtonPressed.NONE) {
      setState(() {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock.move(MoveDirection.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock.move(MoveDirection.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock.rotateRight();
            break;
          default:
            break;
        }

        //sinon le block va continuer de bouger dans la dernière direction
        //jusqu'à sortir du cadre
        performAction = LastButtonPressed.NONE;
      });
    }
  }

  Widget drawTetrisBlock() {
    if (currentBlock == null) {
      // preccaution
      return null;
    }
    //on crée notre liste de points
    List<Positioned> visiblePoints = List();
    //current block
    currentBlock.points.forEach((point) {
      Positioned newPoint = Positioned(
        child: getTetrisPoint(currentBlock.color),
        left: point.x * POINT_SIZE,
        top: point.y * POINT_SIZE,
      );
      visiblePoints.add(newPoint);
    });

// on va aussi dessiner les old blocks
    alivePoints.forEach((point) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(point.color),
          left: point.x * POINT_SIZE,
          top: point.y * POINT_SIZE,
        ),
      );
    });
    return Stack(
      children: visiblePoints,
    );
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
            child: drawTetrisBlock(),
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
              buttonIcon: Icon(Icons.rotate_left),
              nextAction: LastButtonPressed.ROTATE_LEFT,
            ),
            ActionButon(
                onClickedFunction: onActionButtonPressed,
                buttonIcon: Icon(Icons.rotate_right),
                nextAction: LastButtonPressed.ROTATE_RIGHT),
          ],
        )
      ],
    );
  }
}
