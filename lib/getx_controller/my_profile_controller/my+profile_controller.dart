

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController{
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;
  Rx<TextEditingController> refercode = TextEditingController().obs;
}