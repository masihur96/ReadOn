import 'dart:convert';

import 'package:read_on/eBook/ebook_model_classes/product.dart';

HomePageBookListModel homePageBookListModelFromJson(String str) => HomePageBookListModel.fromJson(json.decode(str));


class HomePageBookListModel {
  HomePageBookListModel({
    this.data,
  });

  List<HomePageBookData>? data;

  factory HomePageBookListModel.fromJson(Map<String, dynamic> json) => HomePageBookListModel(
    data: List<HomePageBookData>.from(json["data"].map((x) => HomePageBookData.fromJson(x))),
  );
}

class HomePageBookData {
  HomePageBookData({
    this.catId,
    this.catName,
    this.product,
  });

  String? catId;
  String? catName;
  List<Product>? product;

  factory HomePageBookData.fromJson(Map<String, dynamic> json) => HomePageBookData(
    catId: json["cat_id"],
    catName: json["cat_name"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

}

// class Product {
//   Product({
//     this.id,
//     this.name,
//     this.publicationId,
//     this.categoryId,
//     this.subCategoryId,
//     this.sellingPriceEbook,
//     this.sellingPriceHardcopy,
//     this.bookDescription,
//     this.bookThumbnail,
//     this.writerId,
//     this.offerInPersent,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.wname,
//     this.categoryName,
//     this.slug,
//     this.categoryStatus,
//     this.publicationName,
//     this.publicationImage,
//   });
//
//   String? id;
//   String? name;
//   String? publicationId;
//   String? categoryId;
//   dynamic subCategoryId;
//   String? sellingPriceEbook;
//   String? sellingPriceHardcopy;
//   String? bookDescription;
//   String? bookThumbnail;
//   String? writerId;
//   String?offerInPersent;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? wname;
//   String? categoryName;
//   String? slug;
//   String? categoryStatus;
//   String? publicationName;
//   String? publicationImage;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     publicationId: json["publication_id"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     sellingPriceEbook: json["selling_price_ebook"],
//     sellingPriceHardcopy: json["selling_price_hardcopy"],
//     bookDescription: json["book_description"],
//     bookThumbnail: json["book_thumbnail"],
//     writerId: json["writer_id"],
//     offerInPersent: json["offer_in_persent"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     wname: json["wname"],
//     categoryName: json["category_name"],
//     slug: json["slug"],
//     categoryStatus: json["category_status"],
//     publicationName: json["publication_name"],
//     publicationImage: json["publication_image"],
//   );
// }
