import 'package:flutter/material.dart';

class LoadingWidgetNoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          new Container(
            color: Colors.white,
          ),
          Positioned(
            bottom: 300,
            child: new CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
