import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/api_config.dart';
import 'package:techno_teacher/mode_data/auth/signup_model.dart';
import 'package:techno_teacher/mode_data/letterpad/laterPadModel.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';

import '../../mode_data/school_model/books_response.dart';
import '../../utils/snackbar/custom_snsckbar.dart';

class StudentController extends GetxController {

 RxList<BookData> bookModel =
     List<BookData>.empty(growable: true).obs;
 RxList<LaterPadData> latterPadModel =
     List<LaterPadData>.empty(growable: true).obs;

  Rx<TextEditingController> schoolName = TextEditingController().obs;
  Rx<TextEditingController> studentID = TextEditingController().obs;
  Rx<TextEditingController> adhaar = TextEditingController().obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> bankAccount = TextEditingController().obs;
  Rx<TextEditingController> minority = TextEditingController().obs;
  Rx<TextEditingController> downloads = TextEditingController().obs;
  Rx<TextEditingController> parentIncome = TextEditingController().obs;
  Rx<TextEditingController> handicapType = TextEditingController().obs;


  @override
  void onInit() {
    letterPad();
    super.onInit();
  }

  void checkValidation() {
    if (schoolName.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter School Name");
    } else if (studentID.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter student Id");
    } else if (adhaar.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Adhaar Number");
    } else if (dob.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Date of Birth");
    } else if (bankAccount.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter bank account");
    } else if (minority.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("what is your minority");
    } else if (downloads.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("total downloads");
    } else if (parentIncome.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter Parent income");
    } else if (handicapType.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("define handicap type");
    } else {
      upadateStudentInfo();
    }
  }

  void upadateStudentInfo() async {
    var response =await APiProvider().studentInfo();
    if (response != null) {
      ShowCustomSnackBar().SuccessSnackBar(response.toString());
      Get.off(Homepage());
    }
  }


  void letterPad() async{
    var response = await APiProvider().letterPad();
    if(response !=null){
      latterPadModel.value = response;
      debugPrint("latterPadModel ${latterPadModel.value}");
    }
  }

  void myBooks() async{
    var response = await APiProvider().myBooks();
    if(response !=null){
      bookModel.value = response;
      debugPrint("bookModel ${bookModel.value}");
    }
  }
}
