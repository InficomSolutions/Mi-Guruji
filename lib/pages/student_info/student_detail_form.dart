import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class StudentInfo extends StatelessWidget {

   StudentInfo({Key? key}) : super(key: key);
  final StudentController _controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.7,
        centerTitle: true,
        title: const Text(
          "Teacher Info Form",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            h(20),
            AppTextField(
              controller: _controller.schoolName.value,
              hintText: 'School name',
              inputType: TextInputType.text,
              lableText: 'शाळेचे नाव',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.studentID.value,
              hintText: 'Student ID',
              inputType: TextInputType.text,
              lableText: 'माझी आय डी',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.dob.value,
              hintText: 'Date ot Birth',
              inputType: TextInputType.datetime,
              lableText: 'DOB',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.adhaar.value,
              hintText: '',
              inputType: TextInputType.number,
              lableText: 'Adhaar Number ',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.bankAccount.value,
              hintText: 'Enter Bank Account',
              inputType: TextInputType.number,
              lableText: 'Bank Account Number',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.minority.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'Minority',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),

            AppTextField(
              controller: _controller.downloads.value,
              hintText: '',
              inputType: TextInputType.number,
              lableText: 'Downloads',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),

            AppTextField(
              controller: _controller.parentIncome.value,
              hintText: '',
              inputType: TextInputType.number,
              lableText: 'Parent Income',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.handicapType.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'HandiCap Type',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),

            h(20),
            InkWell(onTap: (){
              _controller.checkValidation();
            },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                      "Submit",
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
