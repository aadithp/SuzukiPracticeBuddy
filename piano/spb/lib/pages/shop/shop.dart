import 'package:SuzukiPracticeBuddy/pages/appPropertiesBloc.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryItemPreview.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryLoadingPage.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/itemPreview.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItemWidget.dart';
import 'package:flutter/material.dart';
import 'shopItem.dart';

class Shop extends StatefulWidget {
  final List<ShopItem> shopItems;
  final int currencyValue;

  Shop(this.shopItems, this.currencyValue);

  @override
  _ShopState createState() => _ShopState(shopItems, currencyValue);
}

class _ShopState extends State<Shop> {
  List<ShopItem> shopItems;
  int currencyValue;

  _ShopState(this.shopItems, this.currencyValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.inventory),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    InventoryLoadingPage(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              title: Text('Shop'),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              actions: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Center(
                    child: Image.asset(
                      'assets/dollar.png',
                      height: 23,
                      width: 23,
                    ),
                  ),
                ),
                Center(
                  child: StreamBuilder<Object>(
                      stream: appBloc.currencyStream,
                      initialData: currencyValue,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                          ),
                        );
                      }),
                ),
              ]),
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder<List<ShopItem>>(
              stream: appBloc.shopStream,
              initialData: shopItems,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(snapshot.data.length, (index) {
                      return Center(
                        child: InkWell(
                          onTap: () async {
                            if (snapshot.data[index].itemOwned == true) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    InventoryItemPreview(snapshot.data[index]),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    ItemPreview(snapshot.data[index]),
                              );
                              setState(() {});
                            }
                          },
                          child: ShopItemWidget(snapshot.data[index]),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
