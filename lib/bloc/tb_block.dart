import 'package:flutter/material.dart';
import 'package:flutter_tetris/bloc/block.dart';
import 'package:flutter_tetris/bloc/point.dart';

//FORMAT DU BLOCK on dirait qur c'est T
//   -
// - - -

class TBlock extends Block {
  //IBlock represente la barre dans tetris. ici on la sort horizontalement
  TBlock(int width) {
    points[0] = Point(x: (width / 2 - 1).floor(), y: 0);
    points[1] = Point(x: (width / 2 + 0).floor(), y: 0);
    points[2] = Point(x: (width / 2 + 1).floor(), y: 0);
    points[3] = Point(x: (width / 2 + 0).floor(), y: -1);
    rotationCenter = points[1];
    color = Colors.orange;
  }
}
