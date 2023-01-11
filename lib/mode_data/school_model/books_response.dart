// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel({
    required this.response,
    required this.data,
  });

  Response response;
  List<BookData> data;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    response: Response.fromJson(json["response"]),
    data: List<BookData>.from(json["data"].map((x) => BookData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BookData {
  BookData({
    required this.id,
    required this.className,
    required this.language,
    required this.bookName,
    required this.downloadLink,
    required this.userId,
    required this.status,
    required this.createdAt,
  });

  String id;
  String className;
  String language;
  String bookName;
  String downloadLink;
  String userId;
  String status;
  DateTime createdAt;

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
    id: json["id"],
    className: json["class_name"],
    language: json["language"],
    bookName: json["book_name"],
    downloadLink: json["download_link"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_name": className,
    "language": language,
    "book_name": bookName,
    "download_link": downloadLink,
    "user_id": userId,
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
