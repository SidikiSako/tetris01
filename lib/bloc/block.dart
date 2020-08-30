import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_tetris/bloc/point.dart';
import 'package:flutter_tetris/widgets/game.dart';

import 'alive_points.dart';

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
      point.y = rotationCenter.y + x - rotationCenter.x;
    });
  }

  void rotateLeft() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    });
  }

  //pour pouvoir arreter la descente du point. On regarde si on a toucher le fond
  bool isAtBottom() {
    //on verifie si un des points de tetris block est tout en bas (y == BOARD_HEIGHT)
    bool isAtBottom = false;
    points.forEach((point) {
      //print("POINT.Y = ${point.y}");
      if (point.y >= BOARD_HEIGHT - 1) {
        print("CE POINT A TOUCHÉ LE BORD DU BAS");
        // -1 parce que board_height = 20 mais
        //nos indices vont de 0 à 19. D'où 20 - 1 = 19

        isAtBottom = true;
      }
    });
    return isAtBottom;
  }
}
