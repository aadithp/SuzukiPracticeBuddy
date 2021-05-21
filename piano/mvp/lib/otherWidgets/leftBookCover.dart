import 'package:flutter/material.dart';

class LeftBookCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
              'assets/practice_book_cover_single_note_black_left.jpg'),
        ),
        border: Border(
          top: BorderSide(width: 3, color: Colors.white),
          left: BorderSide(width: 3, color: Colors.white),
          bottom: BorderSide(width: 3, color: Colors.white),
        ),
      ),
    );
  }
}
