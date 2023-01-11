import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import '../../api_utility/api_config.dart';

class SignUpController extends GetxController {

  Rx<TextEditingController> schoolName = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> emailId = TextEditingController().obs;
  Rx<TextEditingController> schoolAddr = TextEditingController().obs;
  Rx<TextEditingController> foundation = TextEditingController().obs;
  Rx<TextEditingController> udaisNo = TextEditingController().obs;
  Rx<TextEditingController> ssc = TextEditingController().obs;
  Rx<TextEditingController> index = TextEditingController().obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> contact = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> cPassword = TextEditingController().obs;
  RxBool hidePassword = true.obs;


  togglePassword() {
      hidePassword.value = !hidePassword.value;
  }

  void schoolValidation() {
    if (schoolName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your school name");
    } else if (mobileNumber.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your mobile number!");
    } else if (emailId.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your emailID!");
    } else if (schoolAddr.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter school address!");
    } else if (foundation.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter foundtaion date!");
    } else if (udaisNo.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your udaisNo!");
    } else if (ssc.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter school kendra no!");
    } else if (index.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your index!");
    } else {
      registerSchool();
    }
  }

  void registerSchool() async {
    var response = await APiProvider().registrationSchool();
    debugPrint("=======00090893asdsdadasd3333 $response");
    if (response != null) {
      ShowCustomSnackBar().SuccessSnackBar(response);
      Get.off(Homepage());
    }

  }
  void signUpValidation() {
    if (userName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your name");
    } else if (contact.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your mobile number!");
    } else if (password.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your password!");
    } else if (cPassword.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your confirm password!");
    } else if (password.value.text!=cPassword.value.text) {
      ShowCustomSnackBar().ErrorSnackBar("Enter confirm password not match!");
    }  else {
      register();
    }
  }

  void register() async {
    var response = await APiProvider().registration();
    debugPrint("=======00090893asdsdadasd3333 $response");
    if (response != null) {
      Get.off(const Homepage());
     // ShowCustomSnackBar().SuccessSnackBar(response.toString());
    }

  }

}