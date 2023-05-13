import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/api_config.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/mode_data/letterpad/laterPadModel.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/pages/homepage/plans_page.dart';

import '../../mode_data/school_model/books_response.dart';
import '../../utils/snackbar/custom_snsckbar.dart';

class StudentController extends GetxController {
  RxList<BookData> bookModel = List<BookData>.empty(growable: true).obs;
  RxList<LaterPadData> latterPadModel =
      List<LaterPadData>.empty(growable: true).obs;
  // RxList<UserDetails> logindata = List<UserDetails>.empty(growable: true).obs;

  Rx<TextEditingController> schoolName = TextEditingController().obs;
  Rx<TextEditingController> studentclass = TextEditingController().obs;
  Rx<TextEditingController> mobilenumber = TextEditingController().obs;
  Rx<TextEditingController> studentID = TextEditingController().obs;
  Rx<TextEditingController> adhaar = TextEditingController().obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> bankAccount = TextEditingController().obs;
  Rx<TextEditingController> ifsc = TextEditingController().obs;
  Rx<TextEditingController> minority = TextEditingController().obs;
  Rx<TextEditingController> downloads = TextEditingController().obs;
  Rx<TextEditingController> parentIncome = TextEditingController().obs;
  Rx<TextEditingController> handicapType = TextEditingController().obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> mothername = TextEditingController().obs;
  Rx<TextEditingController> cast = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void checkValidation() {
    if (schoolName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter School Name");
    } else if (studentID.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter student Id");
    } else if (studentclass.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter student class");
    } else if (mobilenumber.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Mobile number");
    } else if (adhaar.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Adhaar Number");
    } else if (name.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter name");
    } else if (mothername.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter mother Number");
    } else if (cast.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter cast");
    } else if (dob.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Date of Birth");
    } else if (bankAccount.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter bank account");
    } else if (ifsc.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter ifsc code");
    } else if (minority.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("what is your minority");
    }
    // else if (downloads.value.text.isEmpty) {
    //   ShowCustomSnackBar().ErrorSnackBar("total downloads");
    // }
    else if (parentIncome.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Parent income");
    } else if (handicapType.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("define handicap type");
    } else {
      upadateStudentInfo();
    }
  }

  void upadateStudentInfo() async {
    var response = await APiProvider().studentInfo();
    if (response != null) {
      ShowCustomSnackBar().SuccessSnackBar(response.toString());
      Get.off(Homepage());
    }
  }

  // void letterPad() async {
  //   var response = await APiProvider().letterPad();
  //   if (response != null) {
  //     latterPadModel.value = response;
  //     debugPrint("latterPadModel ${latterPadModel.value}");
  //   }
  // }

  // void myBooks() async {
  //   var response = await APiProvider().myBooks();
  //   print(response);
  //   if (response != null) {
  //     bookModel.value = response;
  //     debugPrint("bookModel ${bookModel.value}");
  //   }
  // }

  login(var mobile, password) async {
    try {
      var response = await http.post(
        Uri.parse(TGuruJiUrl.login),
        body: {"mobileno": mobile, "password": password},
      );
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (int.parse(res['response']['response_code']) == 200) {
        List data =
            await subcribedplans("${res['data']['user_details']['token']}");
        print(data);
        if (data.isEmpty) {
          Get.off(Planspage(token: "${res['data']['user_details']['token']}"));
        } else {
          logindata = res['data']['user_details'];
          Authcontroller()
              .storeToken("${res['data']['user_details']['token']}");
          Authcontroller().expirydate("${data[0]['plan_expiry_date']}");
          Get.off(const Homepage());
        }
        return true;
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']['response_message']);
        return true;
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString());
      return true;
    }
  }
}

subcribedplans(var token) async {
  try {
    var response = await http
        .get(Uri.parse(TGuruJiUrl.getplan), headers: {"token": "$token"});
    debugPrint("=======res ${response.statusCode}");
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return res['data'];
    } else {
      ShowCustomSnackBar().ErrorSnackBar(res['response']['response_message']);
    }
  } catch (e) {
    print(e.toString());
  }
}
