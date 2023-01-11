import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedPrefrences{
  static const String token="LoginToken";
  static const String id="Id";
  static const String name="Name";
  static const String email="Email";
  static const String phoneNumber="Phone";
  final box =  GetStorage();


  void saveToken(String val)async{
    box.write(token,val);
  }
  String getToken(){
    return  box.read(token);
  }

  void saveId(String val)async{
    box.write(id,val);
  }
  String getId(){return box.read(id)??"";}

  void saveName(String val)async{
    box.write(name,val);
  }
  String getName(){return box.read(name)??"";}

  void saveEmail(String val)async{
    box.write(email,val);
  }
  String getEmail(){return box.read(email)??"";}

  void savePhone(String val)async{
    box.write(phoneNumber,val);
  }
  String getPhone(){return box.read(phoneNumber)??"";}

}