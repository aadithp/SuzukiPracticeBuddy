class ReviewPieceIds {
  List<int> ids = [];

  ReviewPieceIds(List<int> ids) {
    this.ids = ids;
  }

  ReviewPieceIds.convertToList(Map<String, dynamic> map) {
    String idsAsString = map['reviewPieceIds'];
    List<String> idsAsStringList = idsAsString.split(",");
    for (var x = 0; x < idsAsStringList.length; x++) {
      this.ids.add(int.parse(idsAsStringList[x]));
    }
  }
}