// To parse this JSON data, do
//
//     final audioBookModel = audioBookModelFromJson(jsonString);

import 'dart:convert';

List<AudioBookModel> audioBookModelFromJson(String str) => List<AudioBookModel>.from(json.decode(str).map((x) => AudioBookModel.fromJson(x)));

String audioBookModelToJson(List<AudioBookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AudioBookModel {
  AudioBookModel({
    this.id,
    this.bookId,
    this.chapterName,
    this.audioPath,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? bookId;
  String? chapterName;
  String? audioPath;
  String? price;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AudioBookModel.fromJson(Map<String, dynamic> json) => AudioBookModel(
    id: json["id"],
    bookId: json["book_id"],
    chapterName: json["chapter_name"],
    audioPath: json["audio_path"],
    price: json["price"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "chapter_name": chapterName,
    "audio_path": audioPath,
    "price": price,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
