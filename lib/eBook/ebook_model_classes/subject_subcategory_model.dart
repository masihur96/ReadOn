// To parse this JSON data, do
//
//     final subjectSubcategoryModel = subjectSubcategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubjectSubcategoryModel> subjectSubcategoryModelFromJson(String str) => List<SubjectSubcategoryModel>.from(json.decode(str).map((x) => SubjectSubcategoryModel.fromJson(x)));

String subjectSubcategoryModelToJson(List<SubjectSubcategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectSubcategoryModel {
  SubjectSubcategoryModel({
    this.id,
    this.categoryId,
    this.subCategoryName,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? categoryId;
  String? subCategoryName;
  String? slug;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SubjectSubcategoryModel.fromJson(Map<String, dynamic> json) => SubjectSubcategoryModel(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryName: json["sub_category_name"],
    slug: json["slug"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_name": subCategoryName,
    "slug": slug,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
