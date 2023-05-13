import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class StudentInfo extends StatefulWidget {
  var valueavailable;
  var studentvalue;
  StudentInfo({Key? key, this.valueavailable, this.studentvalue})
      : super(key: key);

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  final StudentController _controller = Get.put(StudentController());
  var firstdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.valueavailable == true) {
      _controller.adhaar.value.text = widget.studentvalue['adhar_no'];
      _controller.studentclass.value.text = widget.studentvalue['class'];
      _controller.ifsc.value.text = widget.studentvalue['ifsc_code'];
      _controller.mobilenumber.value.text = widget.studentvalue['mobile_num'];
      _controller.bankAccount.value.text =
          widget.studentvalue['bank_account_num'];
      _controller.name.value.text = widget.studentvalue['student_name'];
      _controller.schoolName.value.text =
          latterpaddata.isEmpty ? '' : latterpaddata[0]['school_name'];
      _controller.cast.value.text = widget.studentvalue['cast'];
      firstdate = DateTime.parse(widget.studentvalue['dob']);
      _controller.dob.value.text = widget.studentvalue['dob'];
      _controller.downloads.value.text = widget.studentvalue['downloads'];
      _controller.minority.value.text = widget.studentvalue['minority'];
      _controller.mothername.value.text = widget.studentvalue['mother_name'];
      _controller.studentID.value.text = widget.studentvalue['student_id'];
      _controller.parentIncome.value.text =
          widget.studentvalue['parent_income'];
      _controller.handicapType.value.text =
          widget.studentvalue['handicap_type'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blackcolor,
        elevation: 0.7,
        centerTitle: true,
        title: const Text(
          "विद्यार्थ्याची माहिती",
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
              controller: _controller.studentclass.value,
              hintText: 'class',
              inputType: TextInputType.text,
              lableText: 'class',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.mobilenumber.value,
              hintText: 'mobile number',
              inputType: TextInputType.text,
              lableText: 'mobile number',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.name.value,
              hintText: 'Student Name',
              inputType: TextInputType.text,
              lableText: 'विद्यार्थ्याचे नाव',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.mothername.value,
              hintText: 'Mother Name',
              inputType: TextInputType.text,
              lableText: 'आईचे नाव',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.cast.value,
              hintText: 'Cast',
              inputType: TextInputType.text,
              lableText: 'जात',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            AppTextField(
              controller: _controller.minority.value,
              hintText: '',
              inputType: TextInputType.text,
              lableText: 'अल्पसंख्याक',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: firstdate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2101));
                if (picked != null && picked != firstdate) {
                  setState(() {
                    _controller.dob.value.text = picked.toString();
                  });
                }
              },
              child: AppTextField(
                enable: false,
                controller: _controller.dob.value,
                hintText: 'Date ot Birth',
                inputType: TextInputType.datetime,
                lableText: 'जन्मदिनांक',
                textCapitalization: TextCapitalization.words,
                inputAction: TextInputAction.next,
              ),
            ),
            AppTextField(
              controller: _controller.adhaar.value,
              hintText: '',
              inputType: TextInputType.number,
              lableText: 'आधार नंबर',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.bankAccount.value,
              hintText: 'Enter Bank Account',
              inputType: TextInputType.number,
              lableText: 'बँक खाते नंबर',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _controller.ifsc.value,
              hintText: 'IFSC code',
              inputType: TextInputType.name,
              lableText: 'आय.एफ.एस.सी. कोड',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            // AppTextField(
            //   controller: _controller.downloads.value,
            //   hintText: '',
            //   inputType: TextInputType.number,
            //   lableText: 'डाउनलोड',
            //   textCapitalization: TextCapitalization.words,
            //   inputAction: TextInputAction.next,
            // ),
            AppTextField(
              controller: _controller.parentIncome.value,
              hintText: 'Parent Income',
              inputType: TextInputType.number,
              lableText: 'पालकांचे उत्पन्न',
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
            InkWell(
              onTap: () {
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
                  widget.valueavailable ? "update" : "Submit",
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
