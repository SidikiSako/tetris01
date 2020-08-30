import 'package:flutter/material.dart';
import 'package:flutter_tetris/bloc/point.dart';

class AlivePoint extends Point {
  Color color;

//on appelle le constructeur de la super class en lui passant les parametres qu'il doit initialiser
  AlivePoint(int newX, int newY, Color col) : super(x: newX, y: newY) {
    color = col;
  }

  bool checkIfPointCollide(List<Point> pointList) {
    bool retVal = false;
    pointList.forEach((pointToCheck) {
      if (pointToCheck.x == x && pointToCheck.y == y - 1) {
        retVal = true;
      }
    });
    return retVal;
  }
}
