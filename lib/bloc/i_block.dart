import 'package:flutter/material.dart';
import 'package:flutter_tetris/bloc/block.dart';
import 'package:flutter_tetris/bloc/point.dart';

//FORMAT DU BLOCK
// - - - -

class IBlock extends Block {
  //IBlock represente la barre dans tetris. ici on la sort horizontalement
  IBlock(int width) {
    //width c'est la largeur de notre plateau de jeu
    //on le divise par 2 parce qu'on veut que nos tetris apparaissent
    //en haut au centre
    points[0] = Point(x: (width / 2 - 2).floor(), y: -1);
    points[1] = Point(x: (width / 2 - 1).floor(), y: -1);
    points[2] = Point(x: (width / 2 - 0).floor(), y: -1);
    points[3] = Point(x: (width / 2 + 1).floor(), y: -1);
    rotationCenter = points[1];
    color = Colors.cyanAccent;
  }
}
