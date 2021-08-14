import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:flutter_test/flutter_test.dart';

class ResetTests {
  ResetTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
    group('App reset tests:', () {
      test('Current piece id is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        int currentPieceId =
            await GeneralDBProvider.instance.getCurrentPieceId();

        expect(currentPieceId, 100);
      });

      test('Review list is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        var res = await GeneralDBProvider.instance.getReviewList();
        expect(res, []);
      });

      test('Badge history is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        var res = await GeneralDBProvider.instance.getBadgeHistory('Mon');
        List<String> resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Tue');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Wed');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Thu');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Fri');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Sat');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);

        res = await GeneralDBProvider.instance.getBadgeHistory('Sun');
        resStrings = res[0]['doneStatus'].split(",");
        resStrings.add(res[0]['taskCounter'].toString());
        expect(resStrings, ['false', 'false', 'false', '0']);
      });

      test('Starting currency is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        int value = await GeneralDBProvider.instance.getCurrencyValue();
        expect(value, 0);
      });

      test('Inventory is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        Inventory inventory = await GeneralDBProvider.instance.getInventory();
        expect(inventory.items, []);
      });

      test('Achievements are reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        List<Achievement> achievements =
            await GeneralDBProvider.instance.getAllAchievements();
        bool anyCompleted = false;
        for (Achievement achievement in achievements) {
          if (achievement.completeStatus == true) {
            anyCompleted = true;
          }
        }
        expect(anyCompleted, false);
      });

      test('Total earned coins is reset', () async {
        await GeneralDBProvider.instance.resetAllProgress();
        int value = await GeneralDBProvider.instance.getTotalCoins();
        expect(value, 0);
      });
    });
  }
}
