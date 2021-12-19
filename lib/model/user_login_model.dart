// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.result,
    this.userInfo,
  });

  bool? result;
  List<UserInfo>? userInfo;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    result: json["result"],
    userInfo: List<UserInfo>.from(json["user_info"].map((x) => UserInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "user_info": List<dynamic>.from(userInfo!.map((x) => x.toJson())),
  };
}

class UserInfo {
  UserInfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.device1,
    this.device2,
    this.coin,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  String? device1;
  String? device2;
  String? coin;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    device1: json["device1"],
    device2: json["device2"],
    coin: json["coin"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "device1": device1,
    "device2": device2,
    "coin": coin,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
