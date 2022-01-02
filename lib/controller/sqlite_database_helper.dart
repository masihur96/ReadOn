import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/my_book_info_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends GetxController{

  RxList<MyBookInfoModel> myBookList = RxList<MyBookInfoModel>([]);

  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  String bookInfoTable = 'bookInfoTable';
  String colId = 'id';
  String colBookId = 'bookId';
  String colBookName = 'bookName';
  String colWriterName = 'writerName';
  String colThumbnail = "thumbnail";

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'readOn.db';
    var noteDatabase =
    await openDatabase(path, version: 1, onCreate: _createDB);
    return noteDatabase;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $bookInfoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$colBookId TEXT, $colBookName TEXT, $colWriterName TEXT, $colThumbnail TEXT)');
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<int> insertPurchasedBook(MyBookInfoModel myBookInfoModel) async {
    Database db = await database;
    var result = await db.insert(bookInfoTable, myBookInfoModel.toMap());
    await getMyBookList();
    return result;
  }

  Future<List<Map<String, dynamic>>> getMyBookMapList() async {
    Database db = await database;
    var result = await db.query(bookInfoTable, orderBy: '$colId ASC');
    return result;
  }

  Future<void> getMyBookList() async {
    myBookList.clear();
    var myBookMapList = await getMyBookMapList();
    int count = myBookMapList.length;
    for (int i = 0; i < count; i++) {
      myBookList.add(MyBookInfoModel.fromMapObject(myBookMapList[i]));
      print(myBookList[i].bookId);
    }
    update();
    // ignore: avoid_print
    print("my book length = ${myBookList.length}");
  }

  Future<int> deleteDownloadedBooks(String bookId, int index) async {
    Database db = await database;
    var result =
    await db.rawDelete('DELETE FROM $bookInfoTable WHERE $colBookId = $bookId');
    myBookList.removeAt(index);
    await getMyBookList();
    update();
    return result;
  }

}
