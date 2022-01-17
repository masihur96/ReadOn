import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/book_marks_model.dart';
import 'package:read_on/eBook/ebook_model_classes/chapter_model.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/downloaded_chapter_model.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/my_book_info_model.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class ReadingDatabaseHelper extends GetxController {
  final String domainName = 'https://readon.genextbd.net';

  RxList<MyBookInfoModel> myBookList = RxList<MyBookInfoModel>([]);
  RxList<DownloadedChapterModel> lessonsList =
      RxList<DownloadedChapterModel>([]);

  //bookmarksList
  RxList<BookMarksModel> bookMarksList = RxList<BookMarksModel>([]);

  //noteList
  RxList<NoteModel> noteList = RxList<NoteModel>([]);

  static ReadingDatabaseHelper? _databaseHelper;
  static Database? _database;

  ReadingDatabaseHelper._createInstance(); //Named constructor to create instance of DatabaseHelper

  factory ReadingDatabaseHelper() {
    _databaseHelper ??= ReadingDatabaseHelper._createInstance();
    //This is executed only once,singleton object
    return _databaseHelper!;
  }

  String colId = 'id';
  String colBookId = 'bookId';
  String colChapterName = 'chapterName';

  // Database helper for reading feature

  String bookmarksTable = 'bookMarksTable';
  // String colBookId = 'bookId';
  String colBookmarksTitle = 'bookmarksTitle';
  // String colChapterName = 'chapterName';  conflict data

  // note variables
  String noteTable = 'noteTable';
  // String colBookId = 'bookId';
  String colNoteTitle = 'noteTitle';
  String colNote = 'noteText';

  Future<Database> initializeDatabase() async {
    //Get the directory path for both Android and IOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'readOn.db';

    // Open / create the database at a given path
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return noteDatabase;
  }

  void _createDB(Database db, int version) async {
    //Create Bookmarks SQL table
    await db.execute(
        'CREATE TABLE $bookmarksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colBookId TEXT, $colBookmarksTitle TEXT, $colChapterName TEXT)');
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  // Database helper for reading feature Query
  Future<int> insertBookmarksData(BookMarksModel bookMarksModel) async {
    Database db = await database;
    var result = await db.insert(bookmarksTable, bookMarksModel.toMap());
    await getBookmarksList();
    return result;
  }

  //insert Note Data
  Future<int> insertNoteData(NoteModel noteModel) async {
    Database db = await database;
    var result = await db.insert(noteTable, noteModel.toMap());
    await getNoteList();
    return result;
  }

  Future<List<Map<String, dynamic>>> getBookmarksMapList() async {
    Database db = await database;
    var result = await db.query(bookmarksTable, orderBy: '$colId ASC');
    return result;
  }

  //get BookMarks Map list
  Future<List<Map<String, dynamic>>> getNotMapList() async {
    Database db = await database;
    var result = await db.query(noteTable, orderBy: '$colId ASC');
    return result;
  }

  Future<void> getBookmarksList() async {
    bookMarksList.clear();
    var bookMarksMapList = await getBookmarksMapList();
    int count = bookMarksMapList.length;
    for (int i = 0; i < count; i++) {
      bookMarksList.add(BookMarksModel.fromMapObject(bookMarksMapList[i]));
      print(bookMarksList[i].bookId);
    }
    update();
    // ignore: avoid_print
    print("Bookmarks  length = ${bookMarksList.length}");
  }

  //getNote Data List
  Future<void> getNoteList() async {
    noteList.clear();
    var noteMapList = await getNotMapList();
    int count = noteMapList.length;
    for (int i = 0; i < count; i++) {
      noteList.add(NoteModel.fromMapObject(noteMapList[i]));
      print(noteList[i].bookId);
    }
    update();
    // ignore: avoid_print
    print("Note  length = ${noteList.length}");
  }

  Future<int> deleteBookmarksItem(String bookmarksTitl, int index) async {
    Database db = await database;
    var result = await db.rawDelete(
        'DELETE FROM $bookmarksTable WHERE $colBookmarksTitle = "$bookmarksTitl"');
    bookMarksList.removeAt(index);
    await getBookmarksList();
    update();
    return result;
  }
}
