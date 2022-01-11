import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.device1,
    this.device2,
    this.coin,
    this.point,
    this.dateOfBirth,
    this.institution,
    this.division,
    this.pMNumber,
    this.gender,
    this.userImage,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  String? password;
  dynamic rememberToken;
  String? device1;
  String? device2;
  String? coin;
  String? point;
  dynamic dateOfBirth;
  dynamic institution;
  dynamic division;
  dynamic pMNumber;
  dynamic gender;
  dynamic userImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        device1: json["device1"],
        device2: json["device2"],
        coin: json["coin"],
        point: json["point"],
        dateOfBirth: json["date_of_birth"],
        institution: json["institution"],
        division: json["division"],
        pMNumber: json["p_m_number"],
        gender: json["gender"],
        userImage: json["user_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
