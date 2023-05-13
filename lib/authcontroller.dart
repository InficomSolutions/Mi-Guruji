import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authcontroller {
  final storage = const FlutterSecureStorage();
  void storeToken(String token) async {
    if (kDebugMode) {
      print("storing token and data");
    }

    await storage.write(key: "token", value: token);
  }

  void storerefferal(String token) async {
    if (kDebugMode) {
      print("storing reffer");
    }
    await storage.write(key: "reffer", value: token);
  }

  Future<String?> getreffer() async {
    return await storage.read(key: "reffer");
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  void expirydate(String date) async {
    if (kDebugMode) {
      print("storing token and data");
    }

    await storage.write(key: "date", value: date);
  }

  Future<String?> getexpirydate() async {
    return await storage.read(key: "date");
  }

  void storeUserdata(var data) async {
    if (kDebugMode) {
      print("storing user data and data");
    }

    await storage.write(key: "data", value: jsonEncode(data));
  }

  Future getUserdata() async {
    return await storage.read(key: "data");
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: "token");
  }

  Future<void> deletedate() async {
    return await storage.delete(key: "date");
  }
}
