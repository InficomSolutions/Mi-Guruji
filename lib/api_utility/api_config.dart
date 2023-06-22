import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/getx_controller/auth/sign_up_controller.dart';
import 'package:techno_teacher/getx_controller/teacher_info_controller/teacher_controller.dart';
import '../getx_controller/student_info_controller/student_contorller.dart';
import '../utils/snackbar/custom_snsckbar.dart';
import 'cont_urls.dart';

class APiProvider extends GetConnect {
  registration() async {
    SignUpController _schoolController = Get.put(SignUpController());
    var body = {
      "first_name": _schoolController.userName.value.text,
      "last_name": _schoolController.lastuserName.value.text,
      "referal_code": _schoolController.referal.value.text,
      "mobile": _schoolController.contact.value.text,
      "password": _schoolController.password.value.text,
    };
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await post(
        TGuruJiUrl.registration,
        body,
      );
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(json.encode(response.body));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: res['response']['response_message']);
        Get.back();
        Get.back();
        _schoolController.contact.value.clear();
        _schoolController.userName.value.clear();
        _schoolController.password.value.clear();
        _schoolController.cPassword.value.clear();
        _schoolController.referal.value.clear();
        Authcontroller().storerefferal("");
        _schoolController.lastuserName.value.clear();
      } else {
        Fluttertoast.showToast(msg: res['response']['response_message']);
        Get.back();
      }
    } catch (e) {
      print(e.toString() + "fasf");
      ShowCustomSnackBar().ErrorSnackBar("Try After Some Time");
      Get.back();
    }
  }

  registrationSchool() async {
    SignUpController _schoolController = Get.put(SignUpController());
    var token = await Authcontroller().getToken();
    var body = {
      "school_name": _schoolController.schoolName.value.text,
      "mobile": _schoolController.mobileNumber.value.text,
      "email": _schoolController.emailId.value.text,
      "address": _schoolController.schoolAddr.value.text,
      "foundation_year": _schoolController.foundation.value.text,
      "udais_no": _schoolController.udaisNo.value.text,
      "index_no": _schoolController.index.value.text,
      "center_no": _schoolController.ssc.value.text,
    };
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      var response = await http
          .post(Uri.parse(TGuruJiUrl.schoolRegistration), body: body, headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      print(response.body);
      print(response.runtimeType);
      var res = jsonDecode(response.body);
      print(res);
      Get.back();
    } catch (e) {
      Get.back();
      debugPrint("=============   ${e.toString()}");
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  studentInfo() async {
    StudentController _contorller = Get.put(StudentController());
    var token = await Authcontroller().getToken();
    var body = {
      "school_name": _contorller.schoolName.value.text,
      "class": _contorller.studentclass.value.text,
      "ifsc_code": _contorller.ifsc.value.text,
      "mobile_num": _contorller.mobilenumber.value.text,
      "student_name": _contorller.name.value.text,
      "mother_name": _contorller.mothername.value.text,
      "cast": _contorller.cast.value.text,
      "student_id": _contorller.studentID.value.text,
      "dob": _contorller.dob.value.text,
      "adhar_no": _contorller.adhaar.value.text,
      "parent_income": _contorller.parentIncome.value.text,
      "downloads": "0",
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
      Get.back();
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        _contorller.adhaar.value.clear();
        _contorller.schoolName.value.clear();
        _contorller.studentclass.value.clear();
        _contorller.mobilenumber.value.clear();
        _contorller.ifsc.value.clear();
        _contorller.bankAccount.value.clear();
        _contorller.name.value.clear();
        _contorller.schoolName.value.clear();
        _contorller.cast.value.clear();
        _contorller.dob.value.clear();
        _contorller.downloads.value.clear();
        _contorller.minority.value.clear();
        _contorller.mothername.value.clear();
        _contorller.studentID.value.clear();
        _contorller.parentIncome.value.clear();
        _contorller.handicapType.value.clear();
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res["message"]);
      }
    } catch (e) {
      Get.back();
      debugPrint("=============   ${e.toString()}");
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  teacherInfo() async {
    TeacherInfoController _contorller = Get.put(TeacherInfoController());
    var token = await Authcontroller().getToken();
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
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }
}
