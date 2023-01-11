import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_utility/api_config.dart';
import '../../pages/homepage/homepage.dart';
import '../../utils/snackbar/custom_snsckbar.dart';

class TeacherInfoController extends GetxController {
  Rx<TextEditingController> teacherName = TextEditingController().obs;
  Rx<TextEditingController> schoolName = TextEditingController().obs;
  Rx<TextEditingController> teacherID = TextEditingController().obs;
  Rx<TextEditingController> teacherSalary = TextEditingController().obs;
  Rx<TextEditingController> basic = TextEditingController().obs;
  Rx<TextEditingController> seriesNumber = TextEditingController().obs;
  Rx<TextEditingController> homeAddress = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirth = TextEditingController().obs;
  Rx<TextEditingController> raktgat = TextEditingController().obs;
  Rx<TextEditingController> weight = TextEditingController().obs;
  Rx<TextEditingController> height = TextEditingController().obs;
  Rx<TextEditingController> addharNumber = TextEditingController().obs;
  Rx<TextEditingController> panNumber = TextEditingController().obs;
  Rx<TextEditingController> teacherEmailID = TextEditingController().obs;
  Rx<TextEditingController> policyNumber = TextEditingController().obs;
  Rx<TextEditingController> IFSCCode = TextEditingController().obs;

  void checkValidation() {
    if (teacherName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Teacher Name");
    } else if (schoolName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter School Name");
    } else if (teacherID.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Teacher Id");
    } else if (teacherSalary.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Teacher Salary");
    } else if (basic.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter basic");
    } else if (seriesNumber.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter series number");
    } else if (homeAddress.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter home Address");
    } else if (dateOfBirth.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter DOB");
    } else if (weight.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter weight");
    } else if (height.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter height");
    } else if (addharNumber.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter height");
    } else if (teacherEmailID.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter emailID");
    } else if (policyNumber.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter policy number");
    } else if (IFSCCode.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter IFSC Code");
    } else {
      upadateTeacherInfo();
    }
  }

  void upadateTeacherInfo() async {
    var response = await APiProvider().teacherInfo();
    if (response != null) {
      ShowCustomSnackBar().SuccessSnackBar(response.toString());
      Get.off(Homepage());
    }
  }
}
