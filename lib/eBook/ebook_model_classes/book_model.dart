// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

List<BookModel> bookModelFromJson(String str) => List<BookModel>.from(json.decode(str).map((x) => BookModel.fromJson(x)));

String bookModelToJson(List<BookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookModel {
  BookModel({
    this.id,
    this.name,
    this.publication,
    this.category,
    this.subCategory,
    this.sellingPriceEbook,
    this.sellingPriceHardcopy,
    this.bookDescription,
    this.bookThumbnail,
    this.writerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.wname,
  });

  int? id;
  String? name;
  String? publication;
  String? category;
  dynamic subCategory;
  String? sellingPriceEbook;
  String? sellingPriceHardcopy;
  String? bookDescription;
  String? bookThumbnail;
  String? writerId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? wname;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    name: json["name"],
    publication: json["publication"],
    category: json["category"],
    subCategory: json["sub_category"],
    sellingPriceEbook: json["selling_price_ebook"],
    sellingPriceHardcopy: json["selling_price_hardcopy"],
    bookDescription: json["book_description"],
    bookThumbnail: json["book_thumbnail"],
    writerId: json["writer_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    wname: json["wname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "publication": publication,
    "category": category,
    "sub_category": subCategory,
    "selling_price_ebook": sellingPriceEbook,
    "selling_price_hardcopy": sellingPriceHardcopy,
    "book_description": bookDescription,
    "book_thumbnail": bookThumbnail,
    "writer_id": writerId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "wname": wname,
  };
}
