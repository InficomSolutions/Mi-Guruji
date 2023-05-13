import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/custom_textfield.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class Nutritionfood extends StatefulWidget {
  const Nutritionfood({super.key});

  @override
  State<Nutritionfood> createState() => _NutritionfoodState();
}

class _NutritionfoodState extends State<Nutritionfood> {
  TextEditingController month = TextEditingController();
  TextEditingController rice = TextEditingController();
  TextEditingController greengram = TextEditingController();
  TextEditingController toordal = TextEditingController();
  TextEditingController masoordal = TextEditingController();
  TextEditingController moog = TextEditingController();
  TextEditingController matki = TextEditingController();
  TextEditingController chavali = TextEditingController();
  TextEditingController chickpeas = TextEditingController();
  TextEditingController vatana = TextEditingController();
  TextEditingController jire = TextEditingController();
  TextEditingController mustardseed = TextEditingController();
  TextEditingController turmeric = TextEditingController();
  TextEditingController oniongarlic = TextEditingController();
  TextEditingController oil = TextEditingController();
  TextEditingController salt = TextEditingController();
  TextEditingController garammasala = TextEditingController();
  var slectedmonth;
  GlobalKey<FormState> formKey = GlobalKey();
  void addnutrion() async {
    var token = await Authcontroller().getToken();

    try {
      var response =
          await http.post(Uri.parse(TGuruJiUrl.addnutrition), headers: {
        'token': "$token",
      }, body: {
        'month': "$slectedmonth",
        'rice': rice.text,
        'green_gram': greengram.text,
        'toor_dal': toordal.text,
        'masoor_dal': masoordal.text,
        'matki': matki.text,
        'moog': moog.text,
        'chavali': chavali.text,
        'chickpeas': chickpeas.text,
        'vatana': vatana.text,
        'jire': jire.text,
        'mustard_seeds': mustardseed.text,
        'turmeric': turmeric.text,
        'onion_garlic': oniongarlic.text,
        'oil': oil.text,
        'salt': salt.text,
        'garam_masala': garammasala.text
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
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

  var monthlist = [
    'जानेवारी',
    'फेब्रुवारी',
    'मार्च',
    'एप्रिल',
    'मे',
    'जुन',
    'जुलै',
    'ऑगस्ट',
    'सप्टेंबर',
    'ऑक्टोबर',
    'नोव्हेंबर',
    'डिसेंबर',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      slectedmonth = monthlist[0];
    });
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
          "पोषण आहार",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  value: slectedmonth,
                  items: List.generate(
                      monthlist.length,
                      (index) => DropdownMenuItem(
                          value: monthlist[index],
                          child: Text(monthlist[index]))),
                  onChanged: (value) {
                    setState(() {
                      slectedmonth = value;
                    });
                  },
                ),
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: rice,
                keyboardType: TextInputType.number,
                labelText: 'तांदूळ',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: masoordal,
                keyboardType: TextInputType.number,
                labelText: 'मसूरडाळ',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: matki,
                keyboardType: TextInputType.number,
                labelText: 'मटकी',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: salt,
                keyboardType: TextInputType.number,
                labelText: 'मीठ',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: mustardseed,
                keyboardType: TextInputType.number,
                labelText: 'मोहरी',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: garammasala,
                keyboardType: TextInputType.number,
                labelText: 'गरम मसाला',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: greengram,
                keyboardType: TextInputType.number,
                labelText: 'हरभरा',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: oil,
                keyboardType: TextInputType.number,
                labelText: 'तेल',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: vatana,
                keyboardType: TextInputType.number,
                labelText: 'वाटणा',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: jire,
                keyboardType: TextInputType.number,
                labelText: 'जिरे',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: turmeric,
                keyboardType: TextInputType.number,
                labelText: 'हळद',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: chickpeas,
                keyboardType: TextInputType.number,
                labelText: 'चना',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: chavali,
                keyboardType: TextInputType.number,
                labelText: 'चवळी',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: oniongarlic,
                keyboardType: TextInputType.number,
                labelText: 'कांदा लसूण',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "माहिती रिकामी आहे.";
                  }
                },
                controller: toordal,
                keyboardType: TextInputType.number,
                labelText: 'तुरडाळ',
              ),
              CustomTextField(
                validator: (p0) {
                  if (p0!.length != 10) {
                    return "कृपया आपला मोबाईल नंबर तपासा";
                  }
                },
                controller: moog,
                keyboardType: TextInputType.number,
                labelText: 'मूग',
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    addnutrion();
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
                    "माहिती भरा",
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
}
