import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievementItem.dart';
import 'package:flutter_test/flutter_test.dart';
import 'testWidget.dart';

class AchievementItemTests {
  AchievementItemTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Achievement has correct name and description',
        (WidgetTester tester) async {
      Achievement test = Achievement(
          'testName', false, 'testDescription', 'itemCollector.jpg');

      await tester.pumpWidget(TestWidget(widget: AchievementItem(test)));

      final nameFinder = find.text('testName');
      final descriptionFinder = find.text('testDescription');

      expect(nameFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
    });
  }
}
