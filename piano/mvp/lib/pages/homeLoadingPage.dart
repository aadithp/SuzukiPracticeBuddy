import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/loadingWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/appPropertiesBloc.dart';
import 'package:SuzukiPracticeBuddy/pages/home.dart';
import 'package:flutter/material.dart';
import '../otherWidgets/loadingWidget.dart';

class HomeLoadingPage extends StatefulWidget {
  final int pageIndex;
  HomeLoadingPage(this.pageIndex);

  @override
  _HomeLoadingPageState createState() => _HomeLoadingPageState(pageIndex);
}

class _HomeLoadingPageState extends State<HomeLoadingPage> {
  int pageIndex;
  _HomeLoadingPageState(this.pageIndex);

  int currencyValue;

  getCurrencyValue() async {
    currencyValue = await GeneralDBProvider.instance.getCurrencyValue();
    appBloc.updateCurrencyValue(currencyValue);
    return "Done";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrencyValue(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return LoadingWidget();
        }
        return Home(pageIndex);
      },
    );
  }
}
