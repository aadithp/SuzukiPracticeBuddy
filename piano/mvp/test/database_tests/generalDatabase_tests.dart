import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:flutter_test/flutter_test.dart';

class GeneralDatabaseTests {
  GeneralDatabaseTests.tests() {
    print('------------------------------------= GENERAL DATABASE TESTS =------------------------------------');
    TestWidgetsFlutterBinding.ensureInitialized();
    group('generalDatabase tests:', () {

      test('Current piece id should be updated', () async {
        await GeneralDBProvider.instance.updateCurrentPieceId(1);

        final currentPieceId = await GeneralDBProvider.instance.getCurrentPieceId();

        expect(currentPieceId, 1);
      });

      test('Badge history should be updated', () async {
        await GeneralDBProvider.instance
            .updateBadgeHistory('Mon', 2, [true, false, true]);

        final res = await GeneralDBProvider.instance.getBadgeHistory('Mon');
        List<String> resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());

        expect(resStrings, ['true', 'false', 'true', '2']);
      });

      test('Piece should be added to the review list', () async {
        await GeneralDBProvider.instance.emptyReviewList();
        Piece testPiece = Piece(0, 'test');
        await GeneralDBProvider.instance.addToReviewList(testPiece);

        final res = await GeneralDBProvider.instance.getReviewList();
        List<dynamic> resStrings = [];
        for (int x = 0; x < res.length; x++) {
          resStrings.add(Piece.convertToPiece(res[x]));
        }

        expect(resStrings[0].name, 'test');
      });

      test('Currency value should be updated', () async {
        await GeneralDBProvider.instance.updateCurrencyValue(6790);

        int currencyValue = await GeneralDBProvider.instance.getCurrencyValue();

        expect(currencyValue, 6790);
      });

      test("Bought item should be in user's inventory", () async {
        await GeneralDBProvider.instance.clearInventory();
        await GeneralDBProvider.instance.buyItem(ShopItem('piano_heart.jpg', 'Piano heart background', 0, false));

        Inventory inventory = await GeneralDBProvider.instance.getInventory();
        String itemName = inventory.items[0].itemName;

        expect(itemName, 'Piano heart background');
      });

      test('Background image name should be updated', () async {
        await GeneralDBProvider.instance.changeBackground('test_background.jpg');

        String background = await GeneralDBProvider.instance.getBackground();

        expect(background, 'test_background.jpg');
      });

      test('Achievement should be marked as completed', () async {
        await GeneralDBProvider.instance.resetAchievements();
        await GeneralDBProvider.instance.completeAchievement('Completionist');

        final res = await GeneralDBProvider.instance.getAchievement('Completionist');
        bool status = res.completeStatus;

        expect(status, true);
      });

      test('Total earned coins value should be updated', () async {
        int previousTotal = await GeneralDBProvider.instance.getTotalCoins();
        await GeneralDBProvider.instance.updateTotalCoins(100);

        int newTotal = await GeneralDBProvider.instance.getTotalCoins();

        expect(newTotal, previousTotal + 100);
      });
    });
  }
}
