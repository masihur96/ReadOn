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
    this.name,
    this.publicationId,
    this.categoryId,
    this.subCategoryId,
    this.sellingPriceEbook,
    this.sellingPriceHardcopy,
    this.bookDescription,
    this.bookThumbnail,
    this.writerId,
    this.offerInPersent,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bookname,
    this.bookThumbnil,
    this.wname,
    this.categoryName,
    this.categoryStatus,
    this.publicationName,
    this.publicationImage,
  });

  String? id;
  String? name;
  String? publicationId;
  String? categoryId;
  dynamic subCategoryId;
  String? sellingPriceEbook;
  String? sellingPriceHardcopy;
  String? bookDescription;
  String? bookThumbnail;
  String? writerId;
  String? offerInPersent;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookname;
  String? bookThumbnil;
  String? wname;
  String? categoryName;
  String? categoryStatus;
  String? publicationName;
  String? publicationImage;

  factory Bookdatum.fromJson(Map<String, dynamic> json) => Bookdatum(
        id: json["id"],
        name: json["name"],
        publicationId: json["publication_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        sellingPriceEbook: json["selling_price_ebook"],
        sellingPriceHardcopy: json["selling_price_hardcopy"],
        bookDescription: json["book_description"],
        bookThumbnail: json["book_thumbnail"],
        writerId: json["writer_id"],
        offerInPersent: json["offer_in_persent"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookname: json["bookname"],
        bookThumbnil: json["bookThumbnil"],
        wname: json["wname"],
        categoryName: json["category_name"],
        categoryStatus: json["category_status"],
        publicationName: json["publication_name"],
        publicationImage: json["publication_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "publication_id": publicationId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "selling_price_ebook": sellingPriceEbook,
        "selling_price_hardcopy": sellingPriceHardcopy,
        "book_description": bookDescription,
        "book_thumbnail": bookThumbnail,
        "writer_id": writerId,
        "offer_in_persent": offerInPersent,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "bookname": bookname,
        "bookThumbnil": bookThumbnil,
        "wname": wname,
        "category_name": categoryName,
        "category_status": categoryStatus,
        "publication_name": publicationName,
        "publication_image": publicationImage,
      };
}
