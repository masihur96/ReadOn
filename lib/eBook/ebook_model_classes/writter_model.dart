// To parse this JSON data, do
//
//     final writerModel = writerModelFromJson(jsonString);

import 'dart:convert';

WriterModel writerModelFromJson(String str) => WriterModel.fromJson(json.decode(str));

class WriterModel {
  WriterModel({
    this.data,
  });

  List<WriterInfoData>? data;

  factory WriterModel.fromJson(Map<String, dynamic> json) => WriterModel(
    data: List<WriterInfoData>.from(json["data"].map((x) => WriterInfoData.fromJson(x))),
  );
}

class WriterInfoData {
  WriterInfoData({
    this.totalBooks,
    this.writer,
  });

  int? totalBooks;
  List<Writer>? writer;

  factory WriterInfoData.fromJson(Map<String, dynamic> json) => WriterInfoData(
    totalBooks: json["total_books"],
    writer: List<Writer>.from(json["writer"].map((x) => Writer.fromJson(x))),
  );
}

class Writer {
  Writer({
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

  factory Writer.fromJson(Map<String, dynamic> json) => Writer(
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
    writerDescription: json["writer_description"],
    dateOfBirth: json["date_of_birth"],
    award: json["award"],
  );
}
