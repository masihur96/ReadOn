import 'dart:convert';

List<SiteSettingModel> siteSettingModelFromJson(String str) => List<SiteSettingModel>.from(json.decode(str).map((x) => SiteSettingModel.fromJson(x)));

String siteSettingModelToJson(List<SiteSettingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiteSettingModel {
  SiteSettingModel({
    this.id,
    this.sliderPath,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? sliderPath;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SiteSettingModel.fromJson(Map<String, dynamic> json) => SiteSettingModel(
    id: json["id"],
    sliderPath: json["slider_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slider_path": sliderPath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
