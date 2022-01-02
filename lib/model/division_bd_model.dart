import 'dart:convert';

DivisionBdModel divisionBdModelFromJson(String str) => DivisionBdModel.fromJson(json.decode(str));

String divisionBdModelToJson(DivisionBdModel data) => json.encode(data.toJson());

class DivisionBdModel {
  DivisionBdModel({
    this.status,
    this.data,
  });

  Status? status;
  List<DivisionData>? data;

  factory DivisionBdModel.fromJson(Map<String, dynamic> json) => DivisionBdModel(
    status: Status.fromJson(json["status"]),
    data: List<DivisionData>.from(json["data"].map((x) => DivisionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status!.toJson(),
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DivisionData {
  DivisionData({
    this.id,
    this.division,
    this.divisionbn,
    this.coordinates,
  });

  String? id;
  String? division;
  String? divisionbn;
  String? coordinates;

  factory DivisionData.fromJson(Map<String, dynamic> json) => DivisionData(
    id: json["_id"],
    division: json["division"],
    divisionbn: json["divisionbn"],
    coordinates: json["coordinates"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "division": division,
    "divisionbn": divisionbn,
    "coordinates": coordinates,
  };
}

class Status {
  Status({
    this.code,
    this.message,
    this.date,
  });

  int? code;
  String? message;
  String? date;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    message: json["message"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "date": date,
  };
}
