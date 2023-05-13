import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class Addresult extends StatefulWidget {
  var data;
  var session;
  Addresult({super.key, this.data, this.session});

  @override
  State<Addresult> createState() => _AddresultState();
}

class _AddresultState extends State<Addresult> {
  var addedresult = [];
  getresultdata() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.getresult), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          resultdata = res['data'];
        });

        runtask();
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  runtask() {
    setState(() {
      addedresult.clear();

      if (widget.data != null) {
        session.text = widget.session;
        rollno.text = widget.data['roll_no'];
        studentclass.text = widget.data['class'];
        studentname.text = widget.data['name'];
      }
      for (int i = 0; i < resultdata.length; i++) {
        if (resultdata[i]['student_name'] == studentname.text &&
            resultdata[i]['class'] == studentclass.text &&
            resultdata[i]['session'] == session.text) {
          addedresult.add(resultdata[i]);
        }
      }
    });
  }

  TextEditingController studentname = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController studentclass = TextEditingController();
  TextEditingController session = TextEditingController();
  TextEditingController subjectname = TextEditingController();
  TextEditingController totalmarks = TextEditingController();
  TextEditingController obtainmarks = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKey1 = GlobalKey();
  List<TextEditingController> papermarksobtain = [];
  List<TextEditingController> papermarkstotal = [];

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        addedresult.clear();
        session.text = widget.session;
        rollno.text = widget.data['roll_no'];
        studentclass.text = widget.data['class'];
        studentname.text = widget.data['name'];
        for (int i = 0; i < resultdata.length; i++) {
          if (resultdata[i]['student_name'] == studentname.text &&
              resultdata[i]['class'] == studentclass.text &&
              resultdata[i]['session'] == session.text) {
            addedresult.add(resultdata[i]);
          }
        }
      });
    }
    papermarksobtain = List.generate(
        listofpaper.length, (index) => TextEditingController(),
        growable: false);
    papermarkstotal = List.generate(
        listofpaper.length, (index) => TextEditingController(),
        growable: false);
    getresultdata();
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
        title: Text(
          widget.data != null ? 'आधीचा निकाल' : " निकाल तयार करा",
          style: TextStyle(
              color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getresultdata();
          setState(() {
            addedresult.clear();
            for (int i = 0; i < resultdata.length; i++) {
              if (resultdata[i]['student_name'] == studentname.text &&
                  resultdata[i]['class'] == studentclass.text &&
                  resultdata[i]['session'] == session.text) {
                addedresult.add(resultdata[i]);
              }
            }
          });
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                h(20),
                CustomTextField(
                  onchange: (value) {
                    addedresult.clear();
                    setState(() {
                      for (int i = 0; i < resultdata.length; i++) {
                        if (resultdata[i]['student_name'] == studentname.text &&
                            resultdata[i]['class'] == studentclass.text &&
                            resultdata[i]['session'] == session.text) {
                          addedresult.add(resultdata[i]);
                        }
                      }
                    });
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Value is Empty";
                    }
                  },
                  controller: studentname,
                  labelText: "विद्यार्थीचे नाव",
                ),
                CustomTextField(
                  onchange: (value) {
                    addedresult.clear();
                    setState(() {
                      for (int i = 0; i < resultdata.length; i++) {
                        if (resultdata[i]['student_name'] == studentname.text &&
                            resultdata[i]['class'] == studentclass.text &&
                            resultdata[i]['session'] == session.text) {
                          addedresult.add(resultdata[i]);
                        }
                      }
                    });
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Value is Empty";
                    }
                  },
                  controller: rollno,
                  labelText: "हजरी क्रमांक",
                ),
                CustomTextField(
                  onchange: (value) {
                    addedresult.clear();
                    setState(() {
                      for (int i = 0; i < resultdata.length; i++) {
                        if (resultdata[i]['student_name'] == studentname.text &&
                            resultdata[i]['class'] == studentclass.text &&
                            resultdata[i]['session'] == session.text) {
                          addedresult.add(resultdata[i]);
                        }
                      }
                    });
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Value is Empty";
                    }
                  },
                  controller: studentclass,
                  labelText: "वर्ग",
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        enable: false,
                        onchange: (value) {
                          addedresult.clear();
                          setState(() {
                            for (int i = 0; i < resultdata.length; i++) {
                              if (resultdata[i]['student_name'] ==
                                      studentname.text &&
                                  resultdata[i]['class'] == studentclass.text &&
                                  resultdata[i]['session'] == session.text) {
                                addedresult.add(resultdata[i]);
                              }
                            }
                          });
                          formKey.currentState!.validate();
                        },
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Value is Empty";
                          }
                        },
                        controller: session,
                        labelText: "माध्यम",
                      ),
                    ),
                    DropdownButton(
                      selectedItemBuilder: (context) {
                        return [
                          Center(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                            ),
                          )
                        ];
                      },
                      items: [
                        DropdownMenuItem(child: Text("First"), value: "first"),
                        DropdownMenuItem(
                            child: Text("Second"), value: "second"),
                      ],
                      onChanged: (value) {
                        session.text = "$value";
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return newsubject(
                            edit: false,
                            data: null,
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Icon(Icons.add), Text('निकाल अद्यावत करा')],
                    ),
                  ),
                ),
                Divider(
                  color: blackcolor,
                  thickness: 1,
                ),
                const Text(
                  'निकाल तयार झाला आहे',
                  textScaleFactor: 1.5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: addedresult.length,
                    itemBuilder: (BuildContext context, int index) {
                      // if (resultdata[index]['student_name'] == studentname.text) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(0.35)),
                          child: Column(
                            children: [
                              Text(
                                addedresult[index]['subject'],
                                textScaleFactor: 1.5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addedresult[index]['student_name'],
                                            textScaleFactor: 1.5,
                                          ),
                                          Row(
                                            children: [
                                              Text('माध्यम:-  '),
                                              Text(addedresult[index]
                                                  ['session']),
                                            ],
                                          ),
                                        ],
                                      ),
                                      w(20),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('हजरी क्रमांक '),
                                              Text(addedresult[index]
                                                  ['roll_no']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('वर्ग '),
                                              Text(addedresult[index]['class']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  DropdownButton(
                                    icon: const Icon(Icons.more_vert),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'edit',
                                        child: Text("Edit"),
                                      ),
                                      DropdownMenuItem(
                                        value: 'view',
                                        child: Text("view"),
                                      )
                                    ],
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          var data = addedresult[index];
                                          print(data['id']);
                                          subjectname.text = data['subject'];
                                          papermarksobtain[0].text =
                                              data['daily_observation'];
                                          papermarkstotal[0].text =
                                              data['total_do'];
                                          papermarksobtain[1].text =
                                              data['viva_a'];
                                          papermarkstotal[1].text =
                                              data['total_viva_a'];
                                          papermarksobtain[2].text =
                                              data['practical_activity'];
                                          papermarkstotal[2].text =
                                              data['total_practical_a'];
                                          papermarksobtain[3].text =
                                              data['activity'];
                                          papermarkstotal[3].text =
                                              data['total_activity_a'];
                                          papermarksobtain[4].text =
                                              data['project'];
                                          papermarkstotal[4].text =
                                              data['total_project_a'];
                                          papermarksobtain[5].text =
                                              data['unit_test'];
                                          papermarkstotal[5].text =
                                              data['total_unit_test_a'];
                                          papermarksobtain[6].text =
                                              data['homework'];
                                          papermarkstotal[6].text =
                                              data['total_homework_a'];
                                          papermarksobtain[7].text =
                                              data['other'];
                                          papermarkstotal[7].text =
                                              data['totol_other_a'];
                                          papermarksobtain[8].text =
                                              data['total_a'];
                                          papermarkstotal[8].text =
                                              data['all_total_a'];
                                          papermarksobtain[9].text =
                                              data['viva_b'];
                                          papermarkstotal[9].text =
                                              data['total_viva_b'];
                                          papermarksobtain[10].text =
                                              data['practical'];
                                          papermarkstotal[10].text =
                                              data['total_practical_b'];
                                          papermarksobtain[11].text =
                                              data['therotical'];
                                          papermarkstotal[11].text =
                                              data['total_therotical_b'];
                                          papermarksobtain[12].text =
                                              data['total_b'];
                                          papermarkstotal[12].text =
                                              data['all_total_b'];
                                          papermarksobtain[13].text =
                                              data['total_ab'];
                                          papermarkstotal[13].text =
                                              data['all_total_ab'];
                                          papermarksobtain[14].text =
                                              data['grade'];
                                        },
                                      );
                                      if (value == 'view') {
                                        if (formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return newsubject(
                                                  edit: false,
                                                  data: addedresult[index]);
                                            },
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        }
                                      } else if (value == 'edit') {
                                        if (formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return newsubject(
                                                  edit: true,
                                                  data: addedresult[index]);
                                            },
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  newsubject({var edit, data}) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Dialog(
          child: SingleChildScrollView(
            child: Form(
              key: formKey1,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      getresultdata();
                      setState(() {
                        addedresult.clear();
                        for (int i = 0; i < resultdata.length; i++) {
                          if (resultdata[i]['student_name'] ==
                                  studentname.text &&
                              resultdata[i]['class'] == studentclass.text &&
                              resultdata[i]['session'] == session.text) {
                            addedresult.add(resultdata[i]);
                          }
                        }
                      });
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                CustomTextField(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "माहिती रिकामी आहे.";
                    }
                    return null;
                  },
                  controller: subjectname,
                  labelText: "विषय",
                ),
                ...List.generate(listofpaper.length, (index) {
                  var total_a = 0.0;
                  var obtain_a = 0.0;
                  var total_b = 0.0;
                  var obtain_b = 0.0;
                  if (index == 8) {
                    List.generate(index, (i) {
                      var totalvalue = papermarkstotal[i].text.isEmpty
                          ? 0.0
                          : double.parse(papermarkstotal[i].text);
                      var obtainvalue = papermarksobtain[i].text.isEmpty
                          ? 0.0
                          : double.parse(papermarksobtain[i].text);
                      total_a = total_a + totalvalue;
                      obtain_a = obtain_a + obtainvalue;
                      setState(() {
                        papermarksobtain[8].text = '$obtain_a';
                        papermarkstotal[8].text = '$total_a';
                      });
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: blackcolor,
                            thickness: 1,
                          ),
                          Text(listofpaper[8]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$total_a'),
                              Text('$obtain_a'),
                            ],
                          ),
                          Divider(
                            color: blackcolor,
                            thickness: 1,
                          )
                        ],
                      ),
                    );
                  } else if (index == 12) {
                    var split = [9, 10, 11];

                    List.generate(split.length, (i) {
                      var totalvalue = papermarkstotal[split[i]].text.isEmpty
                          ? 0.0
                          : double.parse(papermarkstotal[split[i]].text);
                      var obtainvalue = papermarksobtain[split[i]].text.isEmpty
                          ? 0.0
                          : double.parse(papermarksobtain[split[i]].text);
                      total_b = total_b + totalvalue;

                      obtain_b = obtain_b + obtainvalue;
                      setState(() {
                        papermarksobtain[12].text = '$obtain_b';
                        papermarkstotal[12].text = '$total_b';
                      });
                    });

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: blackcolor,
                            thickness: 1,
                          ),
                          Text(listofpaper[12]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$total_b'),
                              Text('$obtain_b'),
                            ],
                          ),
                          Divider(
                            color: blackcolor,
                            thickness: 1,
                          )
                        ],
                      ),
                    );
                  } else if (index == 13) {
                    setState(() {
                      papermarksobtain[13].text =
                          "${double.parse(papermarksobtain[12].text) + double.parse(papermarksobtain[8].text)}";
                      papermarkstotal[13].text =
                          "${double.parse(papermarkstotal[12].text) + double.parse(papermarkstotal[8].text)}";
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listofpaper[13]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(papermarkstotal[13].text),
                              Text(papermarksobtain[13].text),
                            ],
                          ),
                          Divider(
                            color: blackcolor,
                            thickness: 1,
                          )
                        ],
                      ),
                    );
                  } else if (index == 14) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listofpaper[14]),
                          CustomTextField(
                            onchange: (value) {
                              formKey1.currentState!.validate();
                              setState(() {});
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'value is empty';
                              }
                            },
                            controller: papermarksobtain[14],
                            labelText: 'श्रेणी',
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listofpaper[index]),
                        Row(
                          children: [
                            papermarkstotal.isEmpty
                                ? Text('')
                                : Expanded(
                                    child: CustomTextField(
                                      onchange: (value) {
                                        formKey1.currentState!.validate();
                                        setState(() {});
                                      },
                                      validator: (p0) {
                                        if (papermarkstotal[index]
                                                .text
                                                .isEmpty &&
                                            papermarksobtain[index]
                                                .text
                                                .isEmpty) {
                                          return null;
                                        } else if (papermarkstotal[index]
                                                .text
                                                .isEmpty &&
                                            papermarksobtain[index]
                                                .text
                                                .isNotEmpty) {
                                          return 'Value is empty';
                                        }
                                        return null;
                                      },
                                      controller: papermarkstotal[index],
                                      keyboardType: TextInputType.number,
                                      labelText: "गुण पैकी",
                                    ),
                                  ),
                            papermarksobtain.isEmpty
                                ? Text('')
                                : Expanded(
                                    child: CustomTextField(
                                      onchange: (value) {
                                        formKey1.currentState!.validate();
                                        setState(() {});
                                      },
                                      validator: (p0) {
                                        if (papermarkstotal[index]
                                                .text
                                                .isEmpty &&
                                            papermarksobtain[index]
                                                .text
                                                .isEmpty) {
                                          return null;
                                        } else if (papermarkstotal[index]
                                                .text
                                                .isNotEmpty &&
                                            papermarksobtain[index]
                                                .text
                                                .isEmpty) {
                                          return 'Value is empty';
                                        }
                                        return null;
                                      },
                                      controller: papermarksobtain[index],
                                      keyboardType: TextInputType.number,
                                      labelText: "प्राप्त गुण",
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                edit == false && data != null
                    ? SizedBox.shrink()
                    : MaterialButton(
                        color: blackcolor,
                        onPressed: () {
                          setState(() {});
                          if (formKey1.currentState!.validate()) {
                            addstudentresult(edit ? data['id'] : 0);
                          }
                        },
                        child: Text(
                          edit == true && data != null ? "update" : "Save",
                          style: TextStyle(color: whitecolor),
                        ),
                      )
              ]),
            ),
          ),
        );
      },
    );
  }

  addstudentresult(var id) async {
    var token = await Authcontroller().getToken();
    try {
      var response = await http.post(Uri.parse(TGuruJiUrl.addresult), headers: {
        'token': "$token",
      }, body: {
        'student_name': studentname.text,
        'roll_no': rollno.text,
        'class': studentclass.text,
        'session': session.text,
        'subject': subjectname.text,
        'daily_observation': papermarksobtain[0].text,
        'total_do': papermarkstotal[0].text,
        'viva_a': papermarksobtain[1].text,
        'total_viva_a': papermarkstotal[1].text,
        'practical_activity': papermarksobtain[2].text,
        'total_practical_a': papermarkstotal[2].text,
        'activity': papermarksobtain[3].text,
        'total_activity_a': papermarkstotal[3].text,
        'project': papermarksobtain[4].text,
        'total_project_a': papermarkstotal[4].text,
        'unit_test': papermarksobtain[5].text,
        'total_unit_test_a': papermarkstotal[5].text,
        'homework': papermarksobtain[6].text,
        'total_homework_a': papermarkstotal[6].text,
        'other': papermarksobtain[7].text,
        'totol_other_a': papermarkstotal[7].text,
        'total_a': papermarksobtain[8].text,
        'all_total_a': papermarkstotal[8].text,
        'viva_b': papermarksobtain[9].text,
        'total_viva_b': papermarkstotal[9].text,
        'practical': papermarksobtain[10].text,
        'total_practical_b': papermarkstotal[10].text,
        'therotical': papermarksobtain[11].text,
        'total_therotical_b': papermarkstotal[11].text,
        'total_b': papermarksobtain[12].text,
        'all_total_b': papermarkstotal[12].text,
        'total_ab': papermarksobtain[13].text,
        'all_total_ab': papermarkstotal[13].text,
        'grade': papermarksobtain[14].text,
        'id': '$id',
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: res['response']["response_message"]);
        getresultdata();
        addedresult.clear();
        setState(() {
          for (int i = 0; i < resultdata.length; i++) {
            if (resultdata[i]['student_name'] == studentname.text &&
                resultdata[i]['class'] == studentclass.text &&
                resultdata[i]['session'] == session.text) {
              addedresult.add(resultdata[i]);
            }
          }
        });
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

  var listofpaper = [
    'दैनंदिन निरीक्षण',
    'तोंडी काम',
    'प्रात्यक्षिक / कृती',
    'उपक्रम /कृती',
    'प्रकल्प',
    'चाचणी  (लेखी)',
    'स्वाध्याय /वर्गकाम',
    'इतर',
    'एकूण अ',
    'तोंडी',
    'प्रात्यक्षिक',
    'लेखी',
    'एकूण ब',
    'अ + ब एकूण',
    'श्रेणी'
  ];
}
