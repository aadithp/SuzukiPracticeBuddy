import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'testWidget.dart';

class PiecePreviewTests {
  PiecePreviewTests.tests() {
    TestWidgetsFlutterBinding.ensureInitialized();
      testWidgets('Piece preview has correct name', (WidgetTester tester) async {
        Piece testPiece = Piece(0, 'test');

        await tester.pumpWidget(TestWidget(widget: PiecePreview(testPiece, Colors.black)));

        final nameFinder = find.text(testPiece.name);

        expect(nameFinder, findsOneWidget);
      });
  }
}