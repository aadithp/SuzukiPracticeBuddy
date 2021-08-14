import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItemWidget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'testWidget.dart';

class ShopItemTests {
  ShopItemTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('shopItem has correct name and price',
        (WidgetTester tester) async {
      ShopItem testItem = ShopItem('astronaut.jpg', 'testName', 0, false);

      await tester.pumpWidget(TestWidget(widget: ShopItemWidget(testItem)));

      final nameFinder = find.text(testItem.itemName);
      final priceFinder = find.text(testItem.itemPrice.toString());

      expect(nameFinder, findsOneWidget);
      expect(priceFinder, findsOneWidget);
    });
  }
}
