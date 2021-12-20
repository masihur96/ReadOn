// To parse this JSON data, do
//
//     final readingModel = readingModelFromJson(jsonString);

import 'dart:convert';

List<ReadingModel> readingModelFromJson(String str) => List<ReadingModel>.from(json.decode(str).map((x) => ReadingModel.fromJson(x)));

String readingModelToJson(List<ReadingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadingModel {
  ReadingModel({
    this.lesson,
    this.lessonStory,
  });

  String? lesson;
  String? lessonStory;

  factory ReadingModel.fromJson(Map<String, dynamic> json) => ReadingModel(
    lesson: json["lesson"],
    lessonStory: json["lesson_story"],
  );

  Map<String, dynamic> toJson() => {
    "lesson": lesson,
    "lesson_story": lessonStory,
  };
}
