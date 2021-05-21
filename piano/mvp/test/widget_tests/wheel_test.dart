import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'testWidget.dart';

class WheelTests {
  WheelTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('All correct pieces appear on wheel', (WidgetTester tester) async {

      Piece testPiece1 = Piece(0, 'testPiece1');
      Piece testPiece2 = Piece(1, 'testPiece2');
      Piece testPiece3 = Piece(2, 'testPiece3');
      Piece testPiece4 = Piece(3, 'testPiece4');
      List<Piece> pieces = [testPiece1, testPiece2, testPiece3, testPiece4];
      Map colorMap = {pieces[0]:Colors.red, pieces[1]:Colors.purple, pieces[2]:Colors.green, pieces[3]:Colors.orange};

      await tester.pumpWidget(TestWidget(widget: Wheel(pieces, colorMap)));

      final pieceFinder1 = find.text(testPiece1.name);
      final pieceFinder2 = find.text(testPiece1.name);
      final pieceFinder3 = find.text(testPiece1.name);
      final pieceFinder4= find.text(testPiece1.name);

      expect(pieceFinder1, findsOneWidget);
      expect(pieceFinder2, findsOneWidget);
      expect(pieceFinder3, findsOneWidget);
      expect(pieceFinder4, findsOneWidget);
    });
  }
}