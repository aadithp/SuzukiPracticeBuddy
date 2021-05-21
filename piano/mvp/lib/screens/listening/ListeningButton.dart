import 'package:flutter/material.dart';

class ListeningButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.0,
      height: 50.0,
      margin: EdgeInsets.all(20),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('Listening'),
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Listening()));
        },
      ),
    );
  }
}
