class ShopItem {
  String imageName;
  String itemName;
  int itemPrice;
  bool itemOwned;

  ShopItem(String imageName, String itemName, int itemPrice, bool itemOwned) {
    this.imageName = imageName;
    this.itemName = itemName;
    this.itemPrice = itemPrice;
    this.itemPrice = itemPrice;
  }

  ShopItem.convertToItem(Map<String, dynamic> map) {
    this.imageName = map['imageName'];
    this.itemName = map['itemName'];
    this.itemPrice = map['itemPrice'];
    if (map['itemOwned'] == 'false') {
      this.itemOwned = false;
    } else {
      this.itemOwned = true;
    }
  }
}
