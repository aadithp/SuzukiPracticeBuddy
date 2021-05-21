import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Student Name",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

        body: ListView(
            children: <Widget>[
              Icon(
                  Icons.star,
                  color: Colors.blueGrey,
                  size: 100
              ),

              Text(
                "This is a message",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic
                ),
              ),

              Text(
                "some more text",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),

              Text(
                  "how much text can I have?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
              ),
            ]
        )
    );
  }
}