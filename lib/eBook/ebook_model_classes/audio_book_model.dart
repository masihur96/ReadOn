import 'dart:convert';

import 'package:read_on/eBook/ebook_model_classes/product.dart';

AudioBookModel audioBookModelFromJson(String str) => AudioBookModel.fromJson(json.decode(str));

class AudioBookModel {
  AudioBookModel({
    this.product,
  });

  List<Product>? product;

  factory AudioBookModel.fromJson(Map<String, dynamic> json) => AudioBookModel(
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );
}
