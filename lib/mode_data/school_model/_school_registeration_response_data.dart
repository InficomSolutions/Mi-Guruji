// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

SchoolModel schoolModelFromJson(String str) => SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  SchoolModel({
    required this.response,
    required this.data,
  });

  Response response;
  bool data;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    response: Response.fromJson(json["response"]),
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "data": data,
  };
}

class Response {
  Response({
    required this.responseCode,
    required this.responseMessage,
  });

  String responseCode;
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
