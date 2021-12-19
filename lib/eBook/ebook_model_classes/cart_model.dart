import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

class CartModel {
  CartModel({
    this.data,
  });

  List<CartData>? data;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    data: List<CartData>.from(json["data"].map((x) => CartData.fromJson(x))),
  );
}

class CartData {
  CartData({
    this.cartId,
    this.cartQuantity,
    this.cartBookType,
    this.cartAudioStatus,
    this.cartSubTotalPrice,
    this.cartbook,
  });

  String? cartId;
  String? cartQuantity;
  String? cartBookType;
  String? cartAudioStatus;
  String? cartSubTotalPrice;
  List<Cartbook>? cartbook;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    cartId: json["cart_id"],
    cartQuantity: json["cart_quantity"],
    cartBookType: json["cart_book_type"],
    cartAudioStatus: json["cart_audio_status"],
    cartSubTotalPrice: json["cart_sub_total_price"],
    cartbook: List<Cartbook>.from(json["cartbook"].map((x) => Cartbook.fromJson(x))),
  );
}

class Cartbook {
  Cartbook({
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
    this.package,
    this.createdAt,
    this.updatedAt,
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
  String? package;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Cartbook.fromJson(Map<String, dynamic> json) => Cartbook(
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
    package: json["package"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}
