import 'dart:convert';

List<SubscriptionModel> subscriptionModelFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.sTitle,
    this.sTaka,
    this.sDescription,
    this.duration,
    this.sStatus,
  });

  int? id;
  String? sTitle;
  String? sTaka;
  String? sDescription;
  String? duration;
  String? sStatus;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"],
    sTitle: json["s_title"],
    sTaka: json["s_taka"],
    sDescription: json["s_description"],
    duration: json["duration"],
    sStatus: json["s_status"],
  );
}
