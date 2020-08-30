import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/bloc/block.dart';
import 'package:flutter_tetris/bloc/i_block.dart';
import 'package:flutter_tetris/bloc/j_block.dart';
import 'package:flutter_tetris/bloc/l_block.dart';
import 'package:flutter_tetris/bloc/s_block.dart';
import 'package:flutter_tetris/bloc/sq_block.dart';
import 'package:flutter_tetris/bloc/tb_block.dart';
import 'package:flutter_tetris/bloc/z_block.dart';
import 'package:flutter_tetris/widgets/game.dart';

//renvoie un random tetris block
Block getRandomBlock() {
  int randomNumber = Random().nextInt(7); //on a 7 blocks -> renvoie 0..6
  switch (randomNumber) {
    case 0:
      return IBlock(BOARD_WIDTH);
    case 1:
      return JBlock(BOARD_WIDTH);
    case 2:
      return LBlock(BOARD_WIDTH);
    case 3:
      return SBlock(BOARD_WIDTH);
    case 4:
      return SQBlock(BOARD_WIDTH);
    case 5:
      return TBlock(BOARD_WIDTH);
    case 6:
      return ZBlock(BOARD_WIDTH);

    default:
      return null;
  }
}

//cette fonction trace un point à l'écran. Il suffit de lui passer la couleur
// du currentTetrisBlock
Widget getTetrisPoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: new BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
    ),
  );
}
