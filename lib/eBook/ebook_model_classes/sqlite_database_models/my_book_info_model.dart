class MyBookInfoModel {
  int? _id;
  String? _bookId;
  String? _bookName;
  String? _writerName;
  String? _bookThumbnail;

  MyBookInfoModel(this._bookId, this._bookName, this._writerName, this._bookThumbnail);

  int? get id => _id;
  String get bookId => _bookId!;
  String get bookName => _bookName!;
  String get writerName => _writerName!;
  String? get bookThumbnail => _bookThumbnail;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['bookId'] = _bookId;
    map['bookName'] = _bookName;
    map['writerName'] = _writerName;
    map['thumbnail'] = _bookThumbnail;
    return map;
  }

  MyBookInfoModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _bookId = map['bookId'];
    _bookName = map['bookName'];
    _writerName = map['writerName'];
    _bookThumbnail = map['thumbnail'];
  }
}