import 'package:flutter/material.dart';

import 'package:flutter_tetris/bloc/point.dart';
import 'package:flutter_tetris/widgets/game.dart';

class Block {
  List<Point> points = List<Point>(4); //chaque element tetric à 4 points
  Point rotationCenter;
  Color color;

  void move(MoveDirection dir) {
    switch (dir) {
      case MoveDirection.LEFT:
        //on deccale chacun des 4 points de notre item tetris vers la gauche
        //donc il faut enlever 1 au x de chaque point
        points.forEach((point) {
          point.x = point.x - 1;
        });
        break;
      case MoveDirection.RIGHT:
        points.forEach((point) {
          point.x = point.x + 1;
        });
        break;
      case MoveDirection.DOWN:
        points.forEach((point) {
          point.y = point.y + 1;
        });
        break;
    }
  }

  void rotateRight() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + point.x - rotationCenter.x;
    });
  }

  void rotateLeft() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - point.x + rotationCenter.x;
    });
  }
}
