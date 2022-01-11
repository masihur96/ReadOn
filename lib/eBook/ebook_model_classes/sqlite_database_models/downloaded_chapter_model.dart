class DownloadedChapterModel {
  int? _id;
  String? _chapterName;
  String? _bookId;
  String? _story;

  DownloadedChapterModel(this._chapterName, this._bookId, this._story);

  int? get id => _id;
  String get chapterName => _chapterName!;
  String get bookId => _bookId!;
  String get story => _story!;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['chapterName'] = _chapterName;
    map['bookId'] = _bookId;
    map['story'] = _story;
    return map;
  }

  DownloadedChapterModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _chapterName = map['chapterName'];
    _bookId = map['bookId'];
    _story = map['story'];
  }
}