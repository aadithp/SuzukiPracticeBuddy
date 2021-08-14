import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TP2.dart';

class TP1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP1State();
}

class TP1State extends State<TP1> {
  double _alpha1 = 0;
  double _alpha2 = 0;
  //
  // MediaQueryData width = MediaQuery.of(context).size.width;
  // double height = MediaQuery.of(context).size.height;

  //width = 411;
  //height = 859;
  @override
  initState() {
    super.initState();
    toggleOpacity();
  }

  toggleOpacity() {
    Future.delayed(Duration(seconds: 1),
        () => setState(() {
          _alpha1 = 1;
        }));
    Future.delayed(Duration(seconds: 3),
        () => setState(() {
          _alpha2 = 1;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
          duration: Duration(seconds: 1),
        opacity: _alpha1,
          child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*0.4,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("This app will help you improve your piano playing.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
              )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.8,
            left: MediaQuery.of(context).size.width*0.8,
            child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: _alpha2,
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_forward_rounded, color: Colors.white,)),
                      onTap: () {
                        print(MediaQuery.of(context).size.width);
                        print(MediaQuery.of(context).size.height);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => TP2(),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                    ),
                  ),
                )
            )
          )
        ]
      ))
    );
  }
}
