import 'dart:async';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';

final appBloc = AppPropertiesBloc();

class AppPropertiesBloc{
  StreamController<int> _currencyValue = StreamController<int>.broadcast();
  StreamController<List<ShopItem>> _shopItems = StreamController<List<ShopItem>>.broadcast();

  Stream<int> get currencyStream => _currencyValue.stream;
  Stream<List<ShopItem>> get shopStream => _shopItems.stream;

  updateCurrencyValue(int newValue) {
    _currencyValue.sink.add(newValue);
  }

  updateShop(List<ShopItem> shopItems) {
    _shopItems.sink.add(shopItems);
  }

  dispose() {
    _currencyValue.close();
    _shopItems.close();
  }
}