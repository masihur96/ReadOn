// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

List<SubscriptionModel> subscriptionModelFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String subscriptionModelToJson(List<SubscriptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.sTitle,
    this.sTaka,
    this.sDescription,
    this.duration,
    this.durationStatus,
    this.sStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? sTitle;
  String? sTaka;
  String? sDescription;
  String? duration;
  String? durationStatus;
  String? sStatus;
  DateTime? createdAt;
  String? updatedAt;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"],
    sTitle: json["s_title"],
    sTaka: json["s_taka"],
    sDescription: json["s_description"],
    duration: json["duration"],
    durationStatus: json["duration_status"],
    sStatus: json["s_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "s_title": sTitle,
    "s_taka": sTaka,
    "s_description": sDescription,
    "duration": duration,
    "duration_status": durationStatus,
    "s_status": sStatus,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
  };
}
