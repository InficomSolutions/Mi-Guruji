import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_controller/teacher_info_controller/teacher_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class TeacherInfo extends StatelessWidget {
  TeacherInfo({Key? key}) : super(key: key);
  TeacherInfoController _teacherInfoController =
      Get.put(TeacherInfoController());

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
              controller: _teacherInfoController.teacherName.value,
              hintText: 'Enter name',
              inputType: TextInputType.text,
              lableText: 'माझे नाव',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.schoolName.value,
              hintText: 'School name',
              inputType: TextInputType.text,
              lableText: 'शाळेचे नाव',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.teacherID.value,
              hintText: 'School ID',
              inputType: TextInputType.text,
              lableText: 'माझा शालार्थ आय डी',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _teacherInfoController.teacherSalary.value,
              hintText: 'Enter salary',
              inputType: TextInputType.text,
              lableText: 'माझी वेतनश्रेणी',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.basic.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'बेसिक ',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.seriesNumber.value,
              hintText: 'Enter name',
              inputType: TextInputType.number,
              lableText: 'भविष्य निर्वाह निधी क्रमांक',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.homeAddress.value,
              hintText: 'Enter address',
              inputType: TextInputType.text,
              lableText: 'घरचा पत्ता ',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.dateOfBirth.value,
              hintText: 'Enter DOB',
              inputType: TextInputType.datetime,
              lableText: 'जन्मदिनांक  ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.raktgat.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'रक्तगट ',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.weight.value,
              hintText: 'Enter name',
              inputType: TextInputType.number,
              lableText: 'वजन ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.height.value,
              hintText: 'Enter name',
              inputType: TextInputType.number,
              lableText: 'उंची ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.addharNumber.value,
              hintText: 'Enter Addhar number',
              inputType: TextInputType.number,
              lableText: 'माझा आधार क्रमांक ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.panNumber.value,
              hintText: 'Enter PAN number',
              inputType: TextInputType.text,
              lableText: 'PAN ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.teacherEmailID.value,
              hintText: 'Enter name',
              inputType: TextInputType.emailAddress,
              lableText: 'ई मेल ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.policyNumber.value,
              hintText: 'Enter policy',
              inputType: TextInputType.number,
              lableText: 'आयुर्विमा पॉलिसी क्रमांक ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _teacherInfoController.IFSCCode.value,
              hintText: 'Enter IFSC',
              inputType: TextInputType.number,
              lableText: 'बँक खाते क्रमांक ',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.done,
            ),
            h(20),
            InkWell(onTap: (){
              _teacherInfoController.checkValidation();
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
