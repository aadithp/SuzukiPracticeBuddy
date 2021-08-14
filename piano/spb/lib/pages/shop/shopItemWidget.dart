import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopItemWidget extends StatelessWidget {
  final item;

  ShopItemWidget(this.item);

  final double width = 175;
  final double height = 175;

  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/backgrounds/' + item.imageName,
            ),
          ),
          border: Border.all(color: Colors.black, width: 2),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            ConditionalBuilder(
              condition: item.itemOwned == true,
              builder: (context) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(0 / 360),
                    child: SizedBox(
                      width: width,
                      height: height / 7,
                      child: Container(
                        color: Color(0xffCC0000),
                        child: Text(
                          'Item Sold',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.75, 0, 0),
              child: Opacity(
                opacity: 0.6,
                child: SizedBox(
                  width: width,
                  height: height / 4,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.77, 0, 0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      item.itemName,
                      style: TextStyle(
                          fontSize: height * 0.08, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/dollar.png',
                        width: 10,
                        height: 10,
                      ),
                      Text(
                        item.itemPrice.toString(),
                        style: TextStyle(
                            fontSize: height * 0.08, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
