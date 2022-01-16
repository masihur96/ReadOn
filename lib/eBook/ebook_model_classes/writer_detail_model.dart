// To parse this JSON data, do
//
//     final writerDetailModel = writerDetailModelFromJson(jsonString);

import 'dart:convert';

List<WriterDetailModel> writerDetailModelFromJson(String str) =>
    List<WriterDetailModel>.from(
        json.decode(str).map((x) => WriterDetailModel.fromJson(x)));

String writerDetailModelToJson(List<WriterDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WriterDetailModel {
  WriterDetailModel({
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
    this.writerPer,
    this.writerStatus,
  });

  String? id;
  String? name;
  String? phone;
  String? image;
  String? email;
  DateTime? emailVerifiedAt;
  String? password;
  String? followerCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? writerDescription;
  DateTime? dateOfBirth;
  String? award;
  String? writerPer;
  String? writerStatus;

  factory WriterDetailModel.fromJson(Map<String, dynamic> json) =>
      WriterDetailModel(
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
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        award: json["award"],
        writerPer: json["writer_per"],
        writerStatus: json["writer_status"],
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
        "writer_description": writerDescription,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "award": award,
        "writer_per": writerPer,
        "writer_status": writerStatus,
      };
}
