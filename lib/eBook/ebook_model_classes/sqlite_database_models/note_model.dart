class NoteModel {
  int? _id;
  String? _bookId;
  String? _noteTitle;
  String? _noteText;

  NoteModel(this._bookId, this._noteTitle, this._noteText);

  int? get id => _id;
  String get bookId => _bookId!;
  String get noteTitle => _noteTitle!;
  String get noteText => _noteText!;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['bookId'] = _bookId;
    map['noteTitle'] = _noteTitle;
    map['noteText'] = _noteText;

    return map;
  }

  NoteModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _bookId = map['bookId'];
    _noteTitle = map['noteTitle'];
    _noteText = map['noteText'];
  }
}
