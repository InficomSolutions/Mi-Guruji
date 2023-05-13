import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class AddSeniority extends StatefulWidget {
  var data;
  AddSeniority({super.key, this.data});

  @override
  State<AddSeniority> createState() => _AddSeniorityState();
}

class _AddSeniorityState extends State<AddSeniority> {
  TextEditingController name = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController postname = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController basic = TextEditingController();
  TextEditingController cast = TextEditingController();
  TextEditingController minority = TextEditingController();
  var joineddate = DateTime.now();
  var presentschooljoineddate = DateTime.now();
  var talukajoineddate = DateTime.now();
  var distpresentdate = DateTime.now();
  var retirementdate = DateTime.now();
  TextEditingController partnerinservice = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController buisnessqualification = TextEditingController();
  TextEditingController education = TextEditingController();
  TextEditingController teachingclass = TextEditingController();
  TextEditingController subject = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  setvalues() {
    setState(() {
      name.text = widget.data['full_name'];
      mobilenumber.text = widget.data['mobile_num'];
      postname.text = widget.data['post_name'];
      salary.text = widget.data['salary'];
      basic.text = widget.data['basic'];
      cast.text = widget.data['cast'];
      minority.text = widget.data['minority'];
      partnerinservice.text = widget.data['partner_in_service'];
      location.text = widget.data['location'];
      buisnessqualification.text = widget.data['business_qualification'];
      education.text = widget.data['education'];
      teachingclass.text = widget.data['teaching_class'];
      subject.text = widget.data['subject'];
      joineddate = DateTime.parse(widget.data['joined_date']);
      presentschooljoineddate =
          DateTime.parse(widget.data['present_school_joined_date']);
      talukajoineddate = DateTime.parse(widget.data['taluka_joined_date']);
      distpresentdate = DateTime.parse(widget.data['dist_present_date']);
      retirementdate = DateTime.parse(widget.data['retirement_date']);
    });
  }

  void addseniority() async {
    var token = await Authcontroller().getToken();
    try {
      var response =
          await http.post(Uri.parse(TGuruJiUrl.addseniority), headers: {
        'token': "$token",
      }, body: {
        'full_name': name.text,
        'mobile_num': mobilenumber.text,
        'post_name': postname.text,
        'salary': salary.text,
        'basic': basic.text,
        'cast': cast.text,
        'minority': minority.text,
        'joined_date':
            '${joineddate.year}/${joineddate.month}/${joineddate.day}',
        'present_school_joined_date':
            '${presentschooljoineddate.year}/${presentschooljoineddate.month}/${presentschooljoineddate.day}',
        'taluka_joined_date':
            '${talukajoineddate.year}/${talukajoineddate.month}/${talukajoineddate.day}',
        'partner_in_service': partnerinservice.text,
        'location': location.text,
        'business_qualification': buisnessqualification.text,
        'education': education.text,
        'dist_present_date':
            '${distpresentdate.year}/${distpresentdate.month}/${distpresentdate.day}',
        'retirement_date':
            '${retirementdate.year}/${retirementdate.month}/${retirementdate.day}',
        'teaching_class': teachingclass.text,
        'subject': subject.text,
        'id': widget.data == null ? '0' : widget.data['id']
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: res['response']["response_message"]);
        Get.back();
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["response_message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      setvalues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whitecolor,
        ),
        backgroundColor: blackcolor,
        elevation: 0.7,
        centerTitle: true,
        title: const Text(
          "Add Seniority",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: name,
                labelText: "full name",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: mobilenumber,
                labelText: "Mobile number",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: postname,
                labelText: "postname",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: salary,
                labelText: "salary",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: basic,
                labelText: "basic",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: cast,
                labelText: "cast",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: minority,
                labelText: "minority",
              ),
              Row(
                children: [
                  datepick(joineddate, 'Joined Date'),
                  datepick(
                      presentschooljoineddate, 'Present school joined date'),
                ],
              ),
              datepick(talukajoineddate, 'Taluka joined date'),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: partnerinservice,
                labelText: "partnerinservice",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: location,
                labelText: "location",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: buisnessqualification,
                labelText: "Business qualification",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: education,
                labelText: "education",
              ),
              Row(
                children: [
                  datepick(distpresentdate, 'Dist present date'),
                  datepick(retirementdate, 'Retirement date'),
                ],
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: teachingclass,
                labelText: "teachingclass",
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Value is Empty";
                  }
                },
                controller: subject,
                labelText: "Subject",
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    addseniority();
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
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  datepick(var selectedDate, text) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101));
              print(picked);
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
                print(picked);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 40,
                        color: whitecolor,
                        child: Center(
                          child: Text(
                            '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                            style: TextStyle(color: blackcolor),
                          ),
                        )),
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
