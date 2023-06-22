import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';

import '../../getx_controller/auth/sign_up_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class SchoolRegistration extends StatefulWidget {
  SchoolRegistration({Key? key}) : super(key: key);

  @override
  State<SchoolRegistration> createState() => _SchoolRegistrationState();
}

class _SchoolRegistrationState extends State<SchoolRegistration> {
  SignUpController _schoolController = Get.put(SignUpController());
  StudentController _studentController = Get.put(StudentController());
  bool progress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (latterpaddata.isNotEmpty) {
      setState(() {
        _schoolController.schoolName.value.text =
            latterpaddata[0]['school_name'] ?? "";
        _schoolController.mobileNumber.value.text =
            latterpaddata[0]['mobile'] ?? "";
        _schoolController.emailId.value.text = latterpaddata[0]['email'] ?? "";
        _schoolController.schoolAddr.value.text =
            latterpaddata[0]['address'] ?? "";
        _schoolController.foundation.value.text =
            latterpaddata[0]['foundation_year'] ?? "";
        _schoolController.index.value.text = latterpaddata[0]['Index_no'] ?? "";
        _schoolController.udaisNo.value.text =
            latterpaddata[0]['udais_no'] ?? "";
        _schoolController.ssc.value.text = latterpaddata[0]['center_no'] ?? "";
      });
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blackcolor,
        elevation: 0.7,
        title: const Text(
          "शाळा माहिती फॉर्म",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              h(0),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.schoolName.value,
                hintText: '',
                inputType: TextInputType.text,
                lableText: 'शाळेचे नाव ',
                textCapitalization: TextCapitalization.words,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.length != 10) {
                    return "कृपया आपला मोबाईल नंबर तपासा";
                  }
                },
                controller: _schoolController.mobileNumber.value,
                hintText: '',
                inputType: TextInputType.phone,
                lableText: 'मोबाईल नं.',
                textCapitalization: TextCapitalization.none,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(p0!)) {
                    return 'ईमेल आयडी तपासा';
                  } else {
                    return null;
                  }
                },
                controller: _schoolController.emailId.value,
                hintText: '',
                inputType: TextInputType.emailAddress,
                lableText: 'इमेल आयडी ',
                textCapitalization: TextCapitalization.none,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.schoolAddr.value,
                hintText: '',
                inputType: TextInputType.text,
                lableText: 'शाळेचा पत्ता ',
                textCapitalization: TextCapitalization.sentences,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.foundation.value,
                hintText: '',
                inputType: TextInputType.text,
                lableText: 'स्थापना',
                textCapitalization: TextCapitalization.words,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.ssc.value,
                hintText: '',
                inputType: TextInputType.text,
                lableText: 'म.रा.मुक्त विद्यालय केंद्र नं.',
                textCapitalization: TextCapitalization.words,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.udaisNo.value,
                hintText: "",
                inputType: TextInputType.number,
                lableText: 'युडायस क्र.',
                textCapitalization: TextCapitalization.none,
                inputAction: TextInputAction.next,
              ),
              AppTextField(
                validate: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: _schoolController.index.value,
                hintText: "",
                inputType: TextInputType.text,
                lableText: 'एस.एस.सी.बोर्ड सांकेतांक',
                textCapitalization: TextCapitalization.none,
                inputAction: TextInputAction.done,
              ),
              h(20),
              progress == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            progress = true;
                          });
                          _schoolController.schoolValidation();
                          setState(() {
                            progress = false;
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                            child: Text(
                          latterpaddata.isEmpty ? "माहिती भरा" : "अद्यावत करा",
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
      ),
    );
  }
}
