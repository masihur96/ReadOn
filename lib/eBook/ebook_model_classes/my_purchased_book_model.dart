// To parse this JSON data, do
//
//     final myPurchasedBookModel = myPurchasedBookModelFromJson(jsonString);

import 'dart:convert';

MyPurchasedBookModel myPurchasedBookModelFromJson(String str) =>
    MyPurchasedBookModel.fromJson(json.decode(str));

String myPurchasedBookModelToJson(MyPurchasedBookModel data) =>
    json.encode(data.toJson());

class MyPurchasedBookModel {
  MyPurchasedBookModel({
    this.data,
  });

  List<Datum>? data;

  factory MyPurchasedBookModel.fromJson(Map<String, dynamic> json) =>
      MyPurchasedBookModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.bookdata,
  });

  List<Bookdatum>? bookdata;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookdata: List<Bookdatum>.from(
            json["bookdata"].map((x) => Bookdatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookdata": List<dynamic>.from(bookdata!.map((x) => x.toJson())),
      };
}

class Bookdatum {
  Bookdatum({
    this.id,
    this.userId,
    this.bookId,
    this.quantity,
    this.bookType,
    this.audioStatus,
    this.subTotalPrice,
    this.createdAt,
    this.updatedAt,
    this.bookname,
    this.bookThumbnil,
    this.wname,
    this.writerId,
    this.categoryName,
    this.categoryStatus,
    this.publicationId,
    this.publicationName,
    this.publicationImage,
  });

  String? id;
  String? userId;
  String? bookId;
  String? quantity;
  String? bookType;
  String? audioStatus;
  String? subTotalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookname;
  String? bookThumbnil;
  String? wname;
  String? writerId;
  String? categoryName;
  String? categoryStatus;
  String? publicationId;
  String? publicationName;
  String? publicationImage;

  factory Bookdatum.fromJson(Map<String, dynamic> json) => Bookdatum(
        id: json["id"],
        userId: json["user_id"],
        bookId: json["book_id"],
        quantity: json["quantity"],
        bookType: json["book_type"],
        audioStatus: json["audio_status"],
        subTotalPrice: json["sub_total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookname: json["bookname"],
        bookThumbnil: json["bookThumbnil"],
        wname: json["wname"],
        writerId: json["writer_id"],
        categoryName: json["category_name"],
        categoryStatus: json["category_status"],
        publicationId: json["publication_id"],
        publicationName: json["publication_name"],
        publicationImage: json["publication_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "book_id": bookId,
        "quantity": quantity,
        "book_type": bookType,
        "audio_status": audioStatus,
        "sub_total_price": subTotalPrice,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "bookname": bookname,
        "bookThumbnil": bookThumbnil,
        "wname": wname,
        "writer_id": writerId,
        "category_name": categoryName,
        "category_status": categoryStatus,
        "publication_id": publicationId,
        "publication_name": publicationName,
        "publication_image": publicationImage,
      };
}
