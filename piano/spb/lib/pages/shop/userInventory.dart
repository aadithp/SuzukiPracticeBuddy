import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryItemPreview.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryItemWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:flutter/material.dart';

import '../appPropertiesBloc.dart';

class UserInventory extends StatefulWidget {
  final Inventory myInventory;
  final int currencyValue;

  UserInventory(this.myInventory, this.currencyValue);

  @override
  _UserInventoryState createState() =>
      _UserInventoryState(myInventory.items, this.currencyValue);
}

class _UserInventoryState extends State<UserInventory> {
  List<ShopItem> inventoryItems;
  int currencyValue;

  _UserInventoryState(this.inventoryItems, this.currencyValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('My items'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: <Widget>[
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
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(inventoryItems.length, (index) {
            return Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        InventoryItemPreview(inventoryItems[index]),
                  );
                },
                child: InventoryItemWidget(inventoryItems[index]),
              ),
            );
          }),
        ),
      ),
    );
  }
}
