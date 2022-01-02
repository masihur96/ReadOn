import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
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
  String? wname;
  String? categoryName;
  String? categoryStatus;
  String? publicationName;
  String? publicationImage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    "wname": wname,
    "category_name": categoryName,
    "category_status": categoryStatus,
    "publication_name": publicationName,
    "publication_image": publicationImage,
  };
}
