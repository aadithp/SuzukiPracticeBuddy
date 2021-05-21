import 'package:SuzukiPracticeBuddy/pages/shop/inventoryItemWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:flutter_test/flutter_test.dart';
import 'testWidget.dart';

class InventoryItemTests {
  InventoryItemTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Inventory item has correct name', (WidgetTester tester) async {
      ShopItem testItem = ShopItem('astronaut.jpg', 'testName', 0, false);

      await tester
          .pumpWidget(TestWidget(widget: InventoryItemWidget(testItem)));

      final nameFinder = find.text(testItem.itemName);

      expect(nameFinder, findsOneWidget);
    });
  }
}
