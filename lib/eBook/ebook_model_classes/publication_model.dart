// To parse this JSON data, do
//
//     final publicationModel = publicationModelFromJson(jsonString);

import 'dart:convert';

List<PublicationModel> publicationModelFromJson(String str) => List<PublicationModel>.from(json.decode(str).map((x) => PublicationModel.fromJson(x)));

String publicationModelToJson(List<PublicationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicationModel {
  PublicationModel({
    this.id,
    this.publicationName,
    this.publicationImage,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? publicationName;
  String? publicationImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PublicationModel.fromJson(Map<String, dynamic> json) => PublicationModel(
    id: json["id"],
    publicationName: json["publication_name"],
    publicationImage: json["publication_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "publication_name": publicationName,
    "publication_image": publicationImage,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
