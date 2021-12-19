import 'dart:convert';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(json.decode(str).map((x) => ReviewModel.fromJson(x)));

class ReviewModel {
  ReviewModel({
    this.id,
    this.userId,
    this.ratting,
    this.bookId,
    this.reviewDetails,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userImage,
  });

  String? id;
  String? userId;
  String? ratting;
  String? bookId;
  String? reviewDetails;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  dynamic userImage;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    userId: json["user_id"],
    ratting: json["ratting"],
    bookId: json["book_id"],
    reviewDetails: json["review_details"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userName: json["user_name"],
    userImage: json["user_image"],
  );

}
