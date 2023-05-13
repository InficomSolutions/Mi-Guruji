import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.response,
    required this.data,
  });

  Response response;
  Data data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
    required this.userDetails,
  });

  UserDetails userDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: UserDetails.fromJson(json["user_details"]),
      );

  Map<String, dynamic> toJson() => {
        "user_details": userDetails.toJson(),
      };
}

class UserDetails {
  UserDetails({
    required this.id,
    required this.token,
    this.name,
    required this.mobileno,
    this.countryCode,
    this.otp,
    required this.email,
    this.profileImg,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.type,
    required this.subscriptionDetails,
    this.shareCode,
  });

  String id;
  String token;
  dynamic name;
  String mobileno;
  dynamic countryCode;
  dynamic otp;
  String email;
  dynamic profileImg;
  String status;
  DateTime createdAt;
  dynamic updatedAt;
  String type;
  SubscriptionDetails subscriptionDetails;
  dynamic shareCode;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        mobileno: json["mobileno"],
        countryCode: json["country_code"],
        otp: json["otp"],
        email: json["email"],
        profileImg: json["profile_img"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        type: json["type"],
        subscriptionDetails:
            SubscriptionDetails.fromJson(json["subscription_details"]),
        shareCode: json["share_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
        "mobileno": mobileno,
        "country_code": countryCode,
        "otp": otp,
        "email": email,
        "profile_img": profileImg,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "type": type,
        "subscription_details": subscriptionDetails.toJson(),
        "share_code": shareCode,
      };
}

class SubscriptionDetails {
  SubscriptionDetails();

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetails();

  Map<String, dynamic> toJson() => {};
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
