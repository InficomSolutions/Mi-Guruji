import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/auth/sign_up_controller.dart';
import 'package:techno_teacher/mode_data/auth/signup_model.dart';

import '../mode_data/school_model/_school_registeration_response_data.dart';
import '../utils/snackbar/custom_snsckbar.dart';
import 'cont_urls.dart';


class APiProvider extends GetConnect {

  regitrationSchool() async {
    SignUpController _schoolController = Get.put(SignUpController());
    var body = {
      "school_name": _schoolController.schoolName.value.text,
      "mobile": _schoolController.mobileNumber.value.text,
      "email": _schoolController.emailId.value.text,
      "address": _schoolController.schoolAddr.value.text,
      "foundation_year": _schoolController.foundation.value.text,
      "udais_no": _schoolController.udaisNo.value.text,
      "index_no": _schoolController.index.value.text
    };
    debugPrint("=======res ${body}");
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await post(
        TGuruJiUrl.schoolRegistration,
        jsonEncode(body),

      );
      debugPrint("=======res ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.back();
        SchoolModel model = SchoolModel.fromJson(response.body);
        ShowCustomSnackBar().SuccessSnackBar(model.response.responseMessage);
        return model;
      } else {
        Get.back();
        ShowCustomSnackBar().ErrorSnackBar(response.body["message"]);
      }
    } catch (e) {
      Get.back();
      debugPrint("=============   ${e.toString()}");
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  regitration() async {
    SignUpController _schoolController = Get.put(SignUpController());
    var body = {
      "mobile": _schoolController.contact.value.text,
      "email": _schoolController.userName.value.text,
      "password": _schoolController.password.value.text,
    };
    debugPrint("=======res ${body}");
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await post(
        TGuruJiUrl.registration,
        body,
      );
      debugPrint("=======res ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.back();
        SignUpModel model = SignUpModel.fromJson(response.body);
        ShowCustomSnackBar().SuccessSnackBar(model.response.responseMessage);
        return model;
      } else {
        Get.back();
        ShowCustomSnackBar().ErrorSnackBar(response.body["message"]);
      }
    } catch (e) {
      Get.back();
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }
}