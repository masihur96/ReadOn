// To parse this JSON data, do
//
//     final writerModel = writerModelFromJson(jsonString);

import 'dart:convert';

List<WriterModel> writerModelFromJson(String str) => List<WriterModel>.from(json.decode(str).map((x) => WriterModel.fromJson(x)));

String writerModelToJson(List<WriterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WriterModel {
  WriterModel({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.followerCount,
    this.createdAt,
    this.updatedAt,
    this.writerDescription,
    this.dateOfBirth,
    this.award,
  });

  int? id;
  String? name;
  String? phone;
  dynamic image;
  String? email;
  DateTime? emailVerifiedAt;
  String? password;
  String? followerCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? writerDescription;
  String? dateOfBirth;
  String? award;

  factory WriterModel.fromJson(Map<String, dynamic> json) => WriterModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    password: json["password"],
    followerCount: json["follower_count"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    writerDescription: json["writer_description"] == null ? null : json["writer_description"],
    dateOfBirth: json["date_of_birth"],
    award: json["award"] == null ? null : json["award"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
    "email": email,
    "email_verified_at": emailVerifiedAt!.toIso8601String(),
    "password": password,
    "follower_count": followerCount,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "writer_description": writerDescription == null ? null : writerDescription,
    "date_of_birth": dateOfBirth,
    "award": award == null ? null : award,
  };
}
