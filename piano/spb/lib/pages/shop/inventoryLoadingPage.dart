import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/userInventory.dart';
import 'package:flutter/material.dart';
import '../../otherWidgets/loadingWidget.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../appPropertiesBloc.dart';

class InventoryLoadingPage extends StatefulWidget {
  @override
  _InventoryLoadingPageState createState() => _InventoryLoadingPageState();
}

class _InventoryLoadingPageState extends State<InventoryLoadingPage> {

  bool loading = true;
  Inventory myInventory;

  //The amount of money a user has, read from the database on startup
  int currencyValue;

  _initValues() async {
    myInventory = await GeneralDBProvider.instance.getInventory();
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
        return UserInventory(myInventory, currencyValue);
      },
    );
  }
}
