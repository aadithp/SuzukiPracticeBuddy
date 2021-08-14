import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shop.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:flutter/material.dart';
import '../../otherWidgets/loadingWidget.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../appPropertiesBloc.dart';

class ShopLoadingPage extends StatefulWidget {
  @override
  _ShopLoadingPageState createState() => _ShopLoadingPageState();
}

class _ShopLoadingPageState extends State<ShopLoadingPage> {

  bool loading = true;
  List<ShopItem> shopItems;

  //The amount of money a user has, read from the database on startup
  int currencyValue;

  _initValues() async {
    shopItems = await GeneralDBProvider.instance.getShopItems();
    setState(() {
      loading = false;
    });
    currencyValue = await GeneralDBProvider.instance.getCurrencyValue();
    appBloc.updateCurrencyValue(currencyValue);
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: loading,
      builder: (context) {
        _initValues();
        return LoadingWidget();
      },
      fallback: (context) {
        return Shop(shopItems, currencyValue);
      },
    );
  }
}
