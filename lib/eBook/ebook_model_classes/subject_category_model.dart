import 'dart:convert';

List<SubjectCategoryModel> subjectCategoryModelFromJson(String str) => List<SubjectCategoryModel>.from(json.decode(str).map((x) => SubjectCategoryModel.fromJson(x)));

String subjectCategoryModelToJson(List<SubjectCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectCategoryModel {
  SubjectCategoryModel({
    this.id,
    this.categoryName,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? categoryName;
  String? slug;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SubjectCategoryModel.fromJson(Map<String, dynamic> json) => SubjectCategoryModel(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "slug": slug,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
