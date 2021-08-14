class Piece {
  int id;
  String name;

  Piece(int id, String name) {
    this.id = id;
    this.name = name;
  }

  Piece.convertToPiece(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
  }
}