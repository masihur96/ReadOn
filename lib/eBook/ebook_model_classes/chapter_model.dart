import 'dart:convert';

List<ChapterModel> chapterModelFromJson(String str) => List<ChapterModel>.from(json.decode(str).map((x) => ChapterModel.fromJson(x)));

String chapterModelToJson(List<ChapterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterModel {
  ChapterModel({
    this.lesson,
    this.lessonStory,
  });

  String? lesson;
  String? lessonStory;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
    lesson: json["lesson"],
    lessonStory: json["lesson_story"],
  );

  Map<String, dynamic> toJson() => {
    "lesson": lesson,
    "lesson_story": lessonStory,
  };
}
