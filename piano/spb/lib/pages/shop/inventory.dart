import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';

class Inventory {
  List<ShopItem> items;

  Inventory(List<ShopItem> items) {
    this.items = items;
  }

  Inventory.convertToInventory(List<Map<String, dynamic>> imageNames, List<Map<String, dynamic>> itemNames) {
    String imageName;
    String itemName;
    List<ShopItem> itemsList = [];
    for (int x = 0; x < imageNames.length; x++) {
      imageName = imageNames[x]['imageName'].toString();
      itemName = itemNames[x]['itemName'].toString();
      itemsList.add(ShopItem(imageName, itemName, 0, true));
    }
    this.items = itemsList;
  }
}