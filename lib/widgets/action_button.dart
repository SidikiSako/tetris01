import 'package:flutter/material.dart';
import 'game.dart';

class ActionButon extends StatelessWidget {
  final Function onClickedFunction;
  final Icon buttonIcon;
  final LastButtonPressed nextAction;
  ActionButon({this.onClickedFunction, this.buttonIcon, this.nextAction});
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: RaisedButton(
          onPressed: () {
            onClickedFunction(nextAction);
          },
          color: Colors.blue,
          child: buttonIcon,
        ),
      ),
    );
  }
}
