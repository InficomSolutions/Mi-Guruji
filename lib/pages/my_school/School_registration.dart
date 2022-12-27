import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_controller/auth/sign_up_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class SchoolRegistration extends StatelessWidget {
   SchoolRegistration({Key? key}) : super(key: key);
  SignUpController _schoolController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.7,
        title: const Text(
          "School Registration Form",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            h(0),
            AppTextField(
              controller: _schoolController.schoolName.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'शाळेचे नाव ',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.mobileNumber.value,
              hintText: '',
              inputType: TextInputType.phone,
              lableText: 'मोबाईल नं.',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.emailId.value,
              hintText: '',
              inputType: TextInputType.emailAddress,
              lableText: 'इमेल आयडी ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.schoolAddr.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'शाळेचा पत्ता ',
              textCapitalization: TextCapitalization.sentences,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.foundation.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'स्थापना',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.ssc.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'म.रा.मुक्त विद्यालय केंद्र नं.',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.udaisNo.value,
              hintText: "",
              inputType: TextInputType.number,
              lableText: 'युडायस क्र.',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller:  _schoolController.index.value,
              hintText: "",
              inputType: TextInputType.text,
              lableText: 'एस.एस.सी.बोर्ड सांकेतांक',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.done,
            ),
            h(20),
            InkWell(onTap: (){
              _schoolController.schoolValidation();
            },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: Colors.black87, borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            h(30),
          ],
        ),
      ),
    );
  }
}
