import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryItemWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class InventoryItemPreview extends StatelessWidget {
  final ShopItem item;
  InventoryItemPreview(this.item);

  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    player.load('backgroundEquip.mp3');
    return Container(
      alignment: Alignment.center,
      child: Dialog(
        child: SizedBox(
          width: 250,
          height: 260,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: InventoryItemWidget(item),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: SizedBox(
                          width: 110,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          player.play('backgroundEquip.mp3');
                          await GeneralDBProvider.instance.changeBackground(item.imageName);
                          Navigator.pop(context, true);
                        },
                        child: SizedBox(
                          width: 110,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
