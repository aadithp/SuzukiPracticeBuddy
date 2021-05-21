import 'package:SuzukiPracticeBuddy/screens/review/ReviewPieceIds.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../screens/review/Piece.dart';
import 'generalDatabase.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  //Initialises database
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "pianoDatabase.db");
    ByteData data = await rootBundle.load(join("assets", "pianoDatabase.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);
    return await openDatabase(path);
  }

  //Queries the pieces table for record of the given piece
  getCurrentPiece(int currentPieceId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * FROM pieces WHERE id = ? LIMIT 1', [currentPieceId]);
    Piece piece = Piece.convertToPiece(res[0]);
    return piece;
  }

  //Clears the reviewPieces table and adds pieces to be reviewed
  updateReviewPiecesTable(ReviewPieceIds reviewPieceIds) async {
    var res = await GeneralDBProvider.instance.emptyReviewList();
    final db = await database;
    for (var x = 0; x < reviewPieceIds.ids.length; x++) {
      res = await db.rawQuery(
          'SELECT * FROM pieces WHERE id = ?', [reviewPieceIds.ids[x]]);
      if (res.toString() != '[]') {
        Piece reviewPiece = Piece.convertToPiece(res[0]);
        GeneralDBProvider.instance.addToReviewList(reviewPiece);
      }
    }
    return res;
  }

  //Queries the pieces table for the piece listed after the given piece
  getNextCurrentPiece(int currentPieceId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * FROM pieces WHERE id > ? ORDER BY id LIMIT 1',
        [currentPieceId]);
    return res;
  }

  //Queries the reviewPieceIds table for record of the given id
  getReviewPieceIds(int reviewPieceId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT reviewPieceIds FROM reviewPiecesMapping WHERE id = ?',
        [reviewPieceId]);
    return res;
  }

  convertToList(List<Map<String, dynamic>> pieces) {
    List<Piece> piecesList = [];
    for (int x = 0; x < pieces.length; x++) {
      int id = pieces[x]['id'];
      String name = pieces[x]['name'];
      piecesList.add(Piece(id, name));
    }
    return piecesList;
  }

  getPieces() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM pieces');
    List<Piece> allPieces = convertToList(res);
    return allPieces;
  }

}
