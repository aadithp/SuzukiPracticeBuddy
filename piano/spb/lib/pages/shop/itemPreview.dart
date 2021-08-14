import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/appPropertiesBloc.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/notEnoughCoins.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItemWidget.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ItemPreview extends StatelessWidget {
  final ShopItem item;

  ItemPreview(this.item);

  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    player.load('purchaseSound.mp3');
    player.load('achievementIn.mp3');
    player.load('achievementOut.mp3');
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
                  child: ShopItemWidget(item),
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
                          bool bought =
                              await GeneralDBProvider.instance.buyItem(item);
                          if (bought) {
                            Achievement achievement = await GeneralDBProvider
                                .instance
                                .getAchievement('New shopper');
                            bool newlyCompleted = await GeneralDBProvider
                                .instance
                                .completeAchievement(achievement.name);

                            player.play('purchaseSound.mp3');
                            appBloc.updateCurrencyValue(await GeneralDBProvider
                                .instance
                                .getCurrencyValue());
                            appBloc.updateShop(await GeneralDBProvider.instance
                                .getShopItems());

                            Inventory inventory =
                                await GeneralDBProvider.instance.getInventory();
                            int noOfItems = inventory.items.length;

                            bool newlyCompleted2 = false;
                            Achievement itemAchievement;
                            if (noOfItems >= 5) {
                              itemAchievement = await GeneralDBProvider.instance
                                  .getAchievement('Item collector');
                              newlyCompleted2 = await GeneralDBProvider.instance
                                  .completeAchievement(itemAchievement.name);
                            }

                            if (noOfItems >= 10) {
                              itemAchievement = await GeneralDBProvider.instance
                                  .getAchievement('Item collector');
                              newlyCompleted2 = await GeneralDBProvider.instance
                                  .completeAchievement(itemAchievement.name);
                            }

                            if (newlyCompleted) {
                              player.play('achievementIn.mp3');
                              Navigator.pop(context, true);
                              Flushbar(
                                title: achievement.name,
                                message: achievement.description,
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                                blockBackgroundInteraction: false,
                                dismissDirection:
                                    FlushbarDismissDirection.VERTICAL,
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context).then(
                                (value) {
                                  player.play('achievementOut.mp3');
                                },
                              );
                            } else {
                              if (newlyCompleted2) {
                                player.play('achievementIn.mp3');
                                Navigator.pop(context, true);
                                Flushbar(
                                  title: itemAchievement.name,
                                  message: itemAchievement.description,
                                  duration: Duration(seconds: 3),
                                  isDismissible: true,
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                  ),
                                  blockBackgroundInteraction: false,
                                  dismissDirection:
                                      FlushbarDismissDirection.VERTICAL,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context).then(
                                  (value) {
                                    player.play('achievementOut.mp3');
                                  },
                                );
                              } else {
                                Navigator.pop(context, true);
                              }
                            }
                          }
                          if (!bought) {
                            Navigator.pop(context, true);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NotEnoughCoins();
                                });
                          }
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
                                'Purchase',
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
