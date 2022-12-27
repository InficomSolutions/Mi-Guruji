// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    required this.response,
    required this.data,
  });

  Response response;
  Data data;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    response: Response.fromJson(json["response"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.mobile,
    required this.email,
   required this.password,
    required this.status,
  });

  String mobile;
  String email;
  String password;
  int status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobile: json["mobile"],
    email: json["email"],
    password: json["password"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "email": email,
    "password": password,
    "status": status,
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
