import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/auth/sign_up_controller.dart';
import 'package:techno_teacher/getx_controller/teacher_info_controller/teacher_controller.dart';
import 'package:techno_teacher/mode_data/auth/signup_model.dart';
import '../getx_controller/student_info_controller/student_contorller.dart';
import '../mode_data/letterpad/laterPadModel.dart';
import '../mode_data/school_model/books_response.dart';
import '../utils/snackbar/custom_snsckbar.dart';
import 'cont_urls.dart';

class APiProvider extends GetConnect {

  registration() async {
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

  registrationSchool() async {
    SignUpController _schoolController = Get.put(SignUpController());
    var token = "210Xag2Pb6U7qTiB";
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
      var response =
          await post(TGuruJiUrl.schoolRegistration, jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      Get.back();
      if (response.statusCode == 200) {
        var data = response.body["response"];
        var msg = data["response_message"];
        debugPrint("=======msg ${msg}");
        return msg;
      } else {
        ShowCustomSnackBar().ErrorSnackBar(response.body["message"]);
      }
    } catch (e) {
      Get.back();
      debugPrint("=============   ${e.toString()}");
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  studentInfo() async {
    StudentController _contorller = Get.put(StudentController());
    var token = "210Xag2Pb6U7qTiB";
    var body = {
      "school_name": _contorller.schoolName.value.text,
      "student_id": _contorller.studentID.value.text,
      "dob": _contorller.dob.value.text,
      "adhar_no": _contorller.adhaar.value.text,
      "parent_income": _contorller.parentIncome.value.text,
      "downloads": _contorller.downloads.value.text,
      "handicap_type": _contorller.handicapType.value.text,
      "bank_account_num": _contorller.bankAccount.value.text,
      "minority": _contorller.minority.value.text,
    };
    debugPrint("=======res ${body}");
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await http.post(Uri.parse(TGuruJiUrl.studentinfo),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'token': "$token",
          });
      debugPrint("=======statusCode ${response.statusCode}");
      debugPrint("=======statusCode ${response.body}");
      Get.back();
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var data = res["response"];
        var msg = data["response_message"];
        debugPrint("=======msg ${msg}");
        return msg;
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res["message"]);
      }
    } catch (e) {
      Get.back();
      debugPrint("=============   ${e.toString()}");
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  teacherInfo() async {
    TeacherInfoController _contorller = Get.put(TeacherInfoController());
    var token = "210Xag2Pb6U7qTiB";
    var body = {
      "school_name": _contorller.schoolName.value.text,
      "shalarth_id": _contorller.teacherID.value.text,
      "vetan_shreni": _contorller.seriesNumber.value.text,
      "sal_basic": _contorller.basic.value.text,
      "bhavishya_nirvah_nidhi": _contorller.raktgat.value.text,
      "resi_address": _contorller.homeAddress.value.text,
      "email": _contorller.teacherEmailID.value.text,
      "blood_group": "A+",
      "weight": _contorller.weight.value.text,
      "height": _contorller.height.value.text,
      "ayurvima_policy": _contorller.policyNumber.value.text,
      "dob": _contorller.dateOfBirth.value.text,
      "fullname": _contorller.teacherName.value.text,
      "adhar_no": _contorller.addharNumber.value.text,
      "bank_account": _contorller.IFSCCode.value.text,
      "pan": _contorller.panNumber.value.text
    };
    debugPrint("=======4454564635 ${body}");
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await http.post(Uri.parse(TGuruJiUrl.teacherInfo),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'token': "$token",
          });
      debugPrint("=======statusCode ${response.statusCode}");
      debugPrint("=======statusCode ${response.body}");
      Get.back();
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var data = res["response"];
        var msg = data["response_message"];
        debugPrint("=======msg ${msg}");
        return msg;
      } else {
        debugPrint("=======4454564635 ${res["message"]}");
        ShowCustomSnackBar().ErrorSnackBar(res["message"]);
      }
    } catch (e) {
      Get.back();
      debugPrint("=============sdsdsahdasd   ${e.toString()}");
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  letterPad() async{
    var token = "210Xag2Pb6U7qTiB";
    try {
      var response = await get(
        TGuruJiUrl.laterPad, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      if (response.statusCode == 200) {
        LaterPadModel model = LaterPadModel.fromJson(response.body);
        return model.data;
      } else {
        ShowCustomSnackBar().ErrorSnackBar(response.body["message"]);
      }
    } catch (e) {
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  myBooks() async{
    var token = "210Xag2Pb6U7qTiB";
    try {
      var response = await get(
          TGuruJiUrl.booklist, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      if (response.statusCode == 200) {
        BookModel model = BookModel.fromJson(response.body);
        return model.data;
      } else {
        ShowCustomSnackBar().ErrorSnackBar(response.body["message"]);
      }
    } catch (e) {
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }

  }
}
