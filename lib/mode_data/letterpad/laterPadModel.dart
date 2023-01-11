// To parse this JSON data, do
//
//     final laterPadModel = laterPadModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LaterPadModel laterPadModelFromJson(String str) => LaterPadModel.fromJson(json.decode(str));

String laterPadModelToJson(LaterPadModel data) => json.encode(data.toJson());

class LaterPadModel {
  LaterPadModel({
    required this.response,
    required this.data,
  });

  Response response;
  List<LaterPadData> data;

  factory LaterPadModel.fromJson(Map<String, dynamic> json) => LaterPadModel(
    response: Response.fromJson(json["response"]),
    data: List<LaterPadData>.from(json["data"].map((x) => LaterPadData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LaterPadData {
  LaterPadData({
    required this.id,
    required this.userId,
    required this.schoolName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.foundationYear,
    required this.centerNo,
    required this.udaisNo,
    required this.indexNo,
    required this.status,
    required this.createdAt,
  });

  String id;
  String userId;
  String schoolName;
  String mobile;
  String email;
  String address;
  String foundationYear;
  String centerNo;
  String udaisNo;
  String indexNo;
  String status;
  DateTime createdAt;

  factory LaterPadData.fromJson(Map<String, dynamic> json) => LaterPadData(
    id: json["id"],
    userId: json["user_id"],
    schoolName: json["school_name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    foundationYear: json["foundation_year"],
    centerNo: json["center_no"],
    udaisNo: json["udais_no"],
    indexNo: json["Index_no"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "school_name": schoolName,
    "mobile": mobile,
    "email": email,
    "address": address,
    "foundation_year": foundationYear,
    "center_no": centerNo,
    "udais_no": udaisNo,
    "Index_no": indexNo,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}

class Response {
  Response({
    required this.responseCode,
    required this.responseMessage,
  });

  int responseCode;
  String responseMessage;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    responseCode: json["response_code"],
    responseMessage: json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "response_message": responseMessage,
  };
}
