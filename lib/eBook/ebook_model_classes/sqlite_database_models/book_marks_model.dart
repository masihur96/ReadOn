class BookMarksModel {
  int? _id;
  String? _bookId;
  String? _bookmarksTitle;
  String? _chapterName;

  BookMarksModel(this._bookId, this._bookmarksTitle, this._chapterName);

  int? get id => _id;
  String get bookId => _bookId!;
  String get bookmarksTitle => _bookmarksTitle!;
  String get chapterName => _chapterName!;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['bookId'] = _bookId;
    map['bookmarksTitle'] = _bookmarksTitle;
    map['chapterName'] = _chapterName;

    return map;
  }

  BookMarksModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _bookId = map['bookId'];
    _bookmarksTitle = map['bookmarksTitle'];
    _chapterName = map['chapterName'];
  }
}
