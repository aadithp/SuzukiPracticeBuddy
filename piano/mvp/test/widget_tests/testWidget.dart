import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final Widget widget;

  const TestWidget({
    Key key,
    @required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Widget',
      home: Scaffold(
          body: widget
      ),
    );
  }
}