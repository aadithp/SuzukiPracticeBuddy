import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          // title: Text(
          //   'Suzuki Practice Buddy',
          //   style: TextStyle(color: Colors.white, fontSize: 18),
          // ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Image.asset(
            'assets/none_3.png',
            width: 32,
            height: 32,
          ),
          actions: [
            //money symbol widget goes here
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
              child: Center(
                child: Image.asset(
                  'assets/dollar.png',
                  height: 23,
                  width: 23,
                ),
              ),
            ),
            //money amount widget here
            Center(
                child: Text(
              '-',
              style: TextStyle(
                color: Colors.amber,
              ),
            )),
          ],
        ),
      ),
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
