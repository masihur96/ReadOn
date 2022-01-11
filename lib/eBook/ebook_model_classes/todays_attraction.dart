import 'dart:convert';

import 'package:read_on/eBook/ebook_model_classes/product.dart';

TodaysAttractionModel todaysAttractionModelFromJson(String str) =>
    TodaysAttractionModel.fromJson(json.decode(str));

String todaysAttractionModelToJson(TodaysAttractionModel data) =>
    json.encode(data.toJson());

class TodaysAttractionModel {
  TodaysAttractionModel({
    this.data,
  });

  List<Attraction>? data;

  factory TodaysAttractionModel.fromJson(Map<String, dynamic> json) =>
      TodaysAttractionModel(
        data: List<Attraction>.from(
            json["data"].map((x) => Attraction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Attraction {
  Attraction({
    this.productList,
  });

  List<Product>? productList;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        productList: List<Product>.from(
            json["Attraction"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Attraction": List<dynamic>.from(productList!.map((x) => x.toJson())),
      };
}
