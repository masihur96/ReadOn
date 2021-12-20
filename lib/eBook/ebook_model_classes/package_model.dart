import 'dart:convert';

List<PackageModel> packageModelFromJson(String str) => List<PackageModel>.from(json.decode(str).map((x) => PackageModel.fromJson(x)));

class PackageModel {
  PackageModel({
    this.id,
    this.packageName,
    this.thumbnail,
    this.publicationId,
    this.categoryId,
    this.sellingPriceEbook,
    this.sellingPriceHardcopy,
    this.bookDescription,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? packageName;
  String? thumbnail;
  String? publicationId;
  String? categoryId;
  String? sellingPriceEbook;
  String? sellingPriceHardcopy;
  String? bookDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    id: json["id"],
    packageName: json["package_name"],
    thumbnail: json["thumbnail"],
    publicationId: json["publication_id"],
    categoryId: json["category_id"],
    sellingPriceEbook: json["selling_price_ebook"],
    sellingPriceHardcopy: json["selling_price_hardcopy"],
    bookDescription: json["book_description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
