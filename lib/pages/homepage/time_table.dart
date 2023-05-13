import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/add_time_table.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Timetablepage extends StatefulWidget {
  const Timetablepage({super.key});

  @override
  State<Timetablepage> createState() => _TimetablepageState();
}

class _TimetablepageState extends State<Timetablepage> {
  var editablevalue;
  var editableweekday;
  var sepratedlisted = [];
  timetable() async {
    var token = await Authcontroller().getToken();
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.gettimetable), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          timetabledata = res['data'];
          for (int i = 0; i < timetabledata.length; i++) {
            if (!serpratetimetablewithclass
                .contains(timetabledata[i]['class'])) {
              serpratetimetablewithclass.add(timetabledata[i]['class']);
            }
          }
          editableweekday = weeklist[0];
          editablevalue = "${serpratetimetablewithclass[0]}";
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  @override
  void initState() {
    super.initState();
    timetable();
    if (serpratetimetablewithclass.isNotEmpty) {
      editablevalue = "${serpratetimetablewithclass[0]}";
      editableweekday = weeklist[0];
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
          "वेळापत्रक",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(Addtimetablepage())!.then((value) => timetable());
              },
              child: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        color: blackcolor,
        onRefresh: () async {
          timetable();
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                serpratetimetablewithclass.isEmpty
                    ? SizedBox.shrink()
                    : DropdownButton(
                        value: editablevalue ?? "No data",
                        items: List.generate(
                            serpratetimetablewithclass.length,
                            (index) => DropdownMenuItem(
                                value: "${serpratetimetablewithclass[index]}",
                                child: Text(
                                  serpratetimetablewithclass[index],
                                  style: TextStyle(
                                      fontSize: 20, color: blackcolor),
                                ))),
                        onChanged: (value) {
                          setState(() {
                            editablevalue = value;
                          });
                        },
                      ),
                serpratetimetablewithclass.isEmpty
                    ? SizedBox.shrink()
                    : DropdownButton(
                        value: editableweekday ?? "No data",
                        items: List.generate(
                            weeklist.length,
                            (index) => DropdownMenuItem(
                                value: "${weeklist[index]}",
                                child: Text(
                                  weeklist[index],
                                  style: TextStyle(
                                      fontSize: 20, color: blackcolor),
                                ))),
                        onChanged: (value) {
                          setState(() {
                            editableweekday = value;
                          });
                        },
                      ),
              ],
            ),
            h(10),
            serpratetimetablewithclass.isEmpty
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        var value;
                        for (int i = 0; i < timetabledata.length; i++) {
                          if (timetabledata[i]['class'] == editablevalue &&
                              timetabledata[i]['day'] == editableweekday) {
                            setState(() {
                              value = timetabledata[i];
                            });
                          }
                        }
                        value != null
                            ? Get.to(Addtimetablepage(
                                data: value,
                              ))!
                                .then((value) {
                                timetable();
                              })
                            : Fluttertoast.showToast(
                                msg: "No Editable value Found");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: whitecolor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: blackcolor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'वेळापत्रक एडीट करा',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: blackcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ),
            serpratetimetablewithclass.isEmpty
                ? SizedBox.shrink()
                : Divider(
                    color: blackcolor,
                  ),
            // Text(
            //   "विद्यार्थी माहिती खालीलप्रमाणे ",
            //   textScaleFactor: 1.5,
            // ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: serpratetimetablewithclass.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.35)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("वर्ग -${serpratetimetablewithclass[index]}"),
                          InkWell(
                              onTap: () async {
                                await sepratedata(
                                    serpratetimetablewithclass[index]);
                                createpdf();
                              },
                              child: Icon(Icons.download)),
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
    );
  }

  sepratedata(var value) {
    for (int i = 0; i < timetabledata.length; i++) {
      if (timetabledata[i]['class'] == value) {
        setState(() {
          sepratedlisted.add(timetabledata[i]);
        });
      }
    }
  }

  createpdf() async {
    print(sepratedlisted);
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Lohit-Marathi.ttf");
    downloadcount();
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.MultiPage(
      build: (context) {
        return [
          pw.Center(
            child: pw.Text('class:-' "${sepratedlisted[0]['class']}",
                style: pw.TextStyle(
                  fontSize: 30,
                  fontFallback: [ttf],
                )),
          ),
          ...List.generate(
              sepratedlisted.length,
              (i) => pw.Column(children: [
                    pw.Center(
                      child: pw.Text(sepratedlisted[i]['day'],
                          style: pw.TextStyle(
                            fontSize: 30,
                            fontFallback: [ttf],
                          )),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Table(border: pw.TableBorder.all(), children: [
                      pw.TableRow(children: [
                        ...List.generate(
                          listoftimes.length,
                          (index) => pw.FittedBox(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child:
                                pw.Text(sepratedlisted[i][listoftimes[index]],
                                    style: pw.TextStyle(
                                      fontFallback: [ttf],
                                    )),
                          )),
                        ),
                      ]),
                      pw.TableRow(children: [
                        ...List.generate(
                          listofsubject.length,
                          (index) => pw.FittedBox(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(
                                listofsubject[index] == ''
                                    ? 'सुट्टी'
                                    : sepratedlisted[i][listofsubject[index]],
                                style: pw.TextStyle(
                                  fontFallback: [ttf],
                                )),
                          )),
                        )
                      ])
                    ]),
                    pw.SizedBox(height: 20),
                  ]))
        ];
      },
    ));
    List<int> bytes = await pdf.save();
    SaveAndLaunchFile(bytes, 'timetable.pdf', context);
  }

  var listoftimes = [
    'time_one',
    'first_period',
    'second_period',
    'time_two',
    'third_period',
    'fourth_period',
    'time_three',
    'fifth_period',
    'sixth_period',
    'seventh_period',
    'time_four',
    'eighth_period',
    'ninth_period'
  ];
  var listofsubject = [
    '',
    'sub_one',
    'sub_two',
    '',
    'sub_three',
    'sub_four',
    '',
    'sub_five',
    'sub_six',
    'sub_seven',
    '',
    'sub_eight',
    'sub_nine'
  ];
}
