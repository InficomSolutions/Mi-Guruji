import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/add_result_page.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

class Resultpage extends StatefulWidget {
  const Resultpage({super.key});

  @override
  State<Resultpage> createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  var studentdata = [];

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
          for (int i = 0; i < resultdata.length; i++) {
            if (!allresultdata.map((x) => x.toString()).contains({
                  'name': resultdata[i]['student_name'],
                  'class': resultdata[i]['class'],
                  'roll_no': resultdata[i]['roll_no']
                }.toString())) {
              allresultdata.add({
                'name': resultdata[i]['student_name'],
                'class': resultdata[i]['class'],
                'roll_no': resultdata[i]['roll_no']
              });
            }
          }
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
    // TODO: implement initState
    super.initState();
    getresultdata();
  }

  bool progress = false;
  var downloadindex;
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
          "निकाल",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => Addresult(
                          data: null,
                          session: null,
                        ))!
                    .then((value) {
                  getresultdata();
                });
              },
              child: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: allresultdata.length,
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
                  Text(
                    allresultdata[index]['name'],
                    textScaleFactor: 1.5,
                  ),
                  progress == true
                      ? downloadindex == index
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox.shrink()
                      : Row(
                          children: [
                            DropdownButton(
                              icon: const Icon(Icons.download),
                              items: const [
                                DropdownMenuItem(
                                  value: 'first',
                                  child: Text("First"),
                                ),
                                DropdownMenuItem(
                                  value: 'second',
                                  child: Text("second"),
                                )
                              ],
                              onChanged: (value) {
                                if (value == 'second') {
                                  studentdata.clear();

                                  for (int i = 0; i < resultdata.length; i++) {
                                    if (resultdata[i]['student_name'] ==
                                            allresultdata[index]['name'] &&
                                        resultdata[i]['class'] ==
                                            allresultdata[index]['class'] &&
                                        resultdata[i]['roll_no'] ==
                                            allresultdata[index]['roll_no'] &&
                                        resultdata[i]['session'] == value) {
                                      setState(() {
                                        studentdata.add(resultdata[i]);
                                      });
                                    }
                                  }

                                  setState(() {
                                    progress = true;
                                    downloadindex = index;
                                  });
                                  // _createpdf();
                                  createpdf().then((value) {
                                    setState(() {
                                      progress = false;
                                    });
                                  });
                                } else if (value == 'first') {
                                  studentdata.clear();

                                  for (int i = 0; i < resultdata.length; i++) {
                                    if (resultdata[i]['student_name'] ==
                                            allresultdata[index]['name'] &&
                                        resultdata[i]['class'] ==
                                            allresultdata[index]['class'] &&
                                        resultdata[i]['roll_no'] ==
                                            allresultdata[index]['roll_no'] &&
                                        resultdata[i]['session'] == value) {
                                      setState(() {
                                        studentdata.add(resultdata[i]);
                                      });
                                    }
                                  }

                                  setState(() {
                                    progress = true;
                                    downloadindex = index;
                                  });
                                  // _createpdf();
                                  createpdf().then((value) {
                                    setState(() {
                                      progress = false;
                                    });
                                  });
                                }
                              },
                            ),
                            DropdownButton(
                              icon: const Icon(Icons.more_vert),
                              items: const [
                                DropdownMenuItem(
                                  value: 'first',
                                  child: Text("First"),
                                ),
                                DropdownMenuItem(
                                  value: 'second',
                                  child: Text("second"),
                                )
                              ],
                              onChanged: (value) {
                                if (value == 'second') {
                                  Get.to(() => Addresult(
                                            data: allresultdata[index],
                                            session: value,
                                          ))!
                                      .then((value) {
                                    getresultdata();
                                  });
                                } else if (value == 'first') {
                                  Get.to(() => Addresult(
                                            data: allresultdata[index],
                                            session: value,
                                          ))!
                                      .then((value) {
                                    getresultdata();
                                  });
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
    );
  }

  createpdf() async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Lohit-Marathi.ttf");
    downloadcount();
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        var newlist = [9, 10, 11, 12];

        return pw.Column(children: [
          pw.Table(border: pw.TableBorder.all(), children: [
            pw.TableRow(children: [
              pw.Column(children: [
                pw.Center(
                  child: pw.FittedBox(
                      child: pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text('अ.क्र.',
                        style: pw.TextStyle(
                          font: ttf,
                        )),
                  )),
                ),
                ...List.generate(
                  3,
                  (index) => pw.Center(
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7),
                      child: pw.Text('',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
                ...List.generate(
                  studentdata.length,
                  (index) => pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border.symmetric(
                            horizontal: pw.BorderSide(color: PdfColors.black))),
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7.5),
                      child: pw.Text('${index + 1}',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
              ]),
              pw.Column(children: [
                pw.Center(
                  child: pw.FittedBox(
                      child: pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text('तपशील',
                        style: pw.TextStyle(
                          font: ttf,
                        )),
                  )),
                ),
                ...List.generate(
                  3,
                  (index) => pw.Center(
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7),
                      child: pw.Text('',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
                ...List.generate(
                  studentdata.length,
                  (index) => pw.Container(
                    padding: pw.EdgeInsets.only(top: 10, bottom: 14),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.symmetric(
                            horizontal: pw.BorderSide(color: PdfColors.black))),
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(studentdata[index]['subject'],
                          style: pw.TextStyle(
                            fontFallback: [ttf],
                          )),
                    )),
                  ),
                ),
              ]),
              pw.Column(children: [
                // pw.Center(
                //   child: pw.FittedBox(
                //       child: pw.Padding(
                //     padding: pw.EdgeInsets.all(8),
                //     child: pw.Text('विषय',
                //         style: pw.TextStyle(
                //           font: ttf,
                //         )),
                //   )),
                // ),
                ...List.generate(
                  4,
                  (index) => pw.Center(
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7),
                      child: pw.Text('',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
                ...List.generate(
                  studentdata.length,
                  (index) => pw.Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(children: [
                      pw.FittedBox(
                          child: pw.Padding(
                        padding: pw.EdgeInsets.all(7),
                        child: pw.Text('प्राप्त गुण',
                            style: pw.TextStyle(
                              font: ttf,
                            )),
                      )),
                    ]),
                    pw.TableRow(children: [
                      pw.FittedBox(
                          child: pw.Padding(
                        padding: pw.EdgeInsets.all(7),
                        child: pw.Text('गुण पैकी',
                            style: pw.TextStyle(
                              font: ttf,
                            )),
                      )),
                    ]),
                  ]),
                ),
              ]),
              pw.Column(children: [
                pw.Table(border: pw.TableBorder.all(), children: [
                  pw.TableRow(children: [
                    pw.SizedBox(
                        child: pw.Center(
                            child: pw.Text('अ ) आकारीक मूल्यमापन',
                                style: pw.TextStyle(
                                  font: ttf,
                                )))),
                  ]),
                ]),
                pw.Table(border: pw.TableBorder.all(), children: [
                  pw.TableRow(
                      children: List.generate(
                    9,
                    (index) => pw.FittedBox(
                        fit: pw.BoxFit.contain,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(resultbox[index],
                              style: pw.TextStyle(
                                font: ttf,
                              )),
                        )),
                  )),
                  pw.TableRow(
                      children: List.generate(
                    9,
                    (index) => pw.Center(
                      child: pw.Text('$index',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    ),
                  )),
                  ...List.generate(
                    studentdata.length,
                    (index) => pw.TableRow(
                        children: List.generate(
                      obtainmarks_a.length,
                      (i) => pw.Center(
                        child: pw.Text(
                            studentdata[index][obtainmarks_a[i]] == '0'
                                ? ""
                                : studentdata[index][obtainmarks_a[i]],
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                      ),
                    )),
                  ),
                  ...List.generate(
                    studentdata.length,
                    (index) => pw.TableRow(
                        children: List.generate(
                      total_a.length,
                      (i) => pw.Center(
                        child: pw.Text(
                            studentdata[index][total_a[i]] == '0'
                                ? ""
                                : studentdata[index][total_a[i]],
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                      ),
                    )),
                  )
                ]),
              ]),
              pw.Column(children: [
                pw.Table(border: pw.TableBorder.all(), children: [
                  pw.TableRow(children: [
                    pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text('ब )संकलित मूल्यमापन',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ]),
                ]),
                pw.Table(border: pw.TableBorder.all(), children: [
                  pw.TableRow(
                      children: List.generate(
                    newlist.length,
                    (index) => pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(resultbox[newlist[index]],
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  )),
                  pw.TableRow(
                      children: List.generate(
                    newlist.length,
                    (index) => pw.Center(
                      child: pw.Text('${newlist[index]}',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    ),
                  )),
                  ...List.generate(
                    studentdata.length,
                    (index) => pw.TableRow(
                        children: List.generate(
                      obtainmarks_b.length,
                      (i) => pw.Center(
                        child: pw.Text(
                            studentdata[index][obtainmarks_b[i]] == '0'
                                ? ""
                                : studentdata[index][obtainmarks_b[i]],
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                      ),
                    )),
                  ),
                  ...List.generate(
                    studentdata.length,
                    (index) => pw.TableRow(
                        children: List.generate(
                      total_b.length,
                      (i) => pw.Center(
                        child: pw.Text(
                            studentdata[index][total_b[i]] == '0'
                                ? ""
                                : studentdata[index][total_b[i]],
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                      ),
                    )),
                  )
                ]),
              ]),
              pw.Column(children: [
                pw.Center(
                  child: pw.FittedBox(
                      child: pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(resultbox[13],
                        style: pw.TextStyle(
                          font: ttf,
                        )),
                  )),
                ),
                ...List.generate(
                  3,
                  (index) => pw.Center(
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7),
                      child: pw.Text('',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
                ...List.generate(
                  studentdata.length,
                  (index) => pw.Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(
                      children: [
                        pw.Center(
                          child: pw.Text(
                              studentdata[index]['total_ab'] == '0'
                                  ? ''
                                  : studentdata[index]['total_ab'],
                              style: pw.TextStyle(font: ttf, fontSize: 10)),
                        )
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Center(
                          child: pw.Text(
                              studentdata[index]['all_total_ab'] == '0'
                                  ? ""
                                  : studentdata[index]['all_total_ab'],
                              style: pw.TextStyle(font: ttf, fontSize: 10)),
                        )
                      ],
                    ),
                  ]),
                ),
              ]),
              pw.Column(children: [
                pw.Center(
                  child: pw.FittedBox(
                      child: pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(resultbox[14],
                        style: pw.TextStyle(
                          font: ttf,
                        )),
                  )),
                ),
                ...List.generate(
                  3,
                  (index) => pw.Center(
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.all(7),
                      child: pw.Text('',
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    )),
                  ),
                ),
                ...List.generate(
                  studentdata.length,
                  (index) => pw.Container(
                    // padding: pw.EdgeInsets.only(top: 8, bottom: 12),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.symmetric(
                            horizontal: pw.BorderSide(color: PdfColors.black))),
                    child: pw.FittedBox(
                        child: pw.Padding(
                      padding: pw.EdgeInsets.only(top: 8, bottom: 10),
                      child: pw.Text(studentdata[index]['grade'],
                          style: pw.TextStyle(
                            fontFallback: [ttf],
                          )),
                    )),
                  ),
                ),
              ]),
            ]),
          ]),
        ]);
      },
    ));
    List<int> bytes = await pdf.save();
    SaveAndLaunchFile(
        bytes,
        'result${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.pdf',
        context);
  }

  multipleresultdata(var ttf, index) {
    return pw.TableRow(children: [
      pw.Center(
        child: pw.Text('${index + 1}',
            style: pw.TextStyle(font: ttf, fontSize: 10)),
      ),
      pw.FittedBox(
        child: pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text(studentdata[index]['subject'],
              style: pw.TextStyle(
                fontFallback: [ttf],
              )),
        ),
      ),
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(children: [
          pw.FittedBox(
              child: pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text('प्राप्त गुण',
                style: pw.TextStyle(
                  font: ttf,
                )),
          )),
        ]),
        pw.TableRow(children: [
          pw.FittedBox(
              child: pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text('गुण पैकी',
                style: pw.TextStyle(
                  font: ttf,
                )),
          )),
        ]),
      ]),
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(
            children: List.generate(
          obtainmarks_a.length,
          (i) => pw.Center(
            child: pw.Text(studentdata[index][obtainmarks_a[i]],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        )),
        pw.TableRow(
            children: List.generate(
          total_a.length,
          (i) => pw.Center(
            child: pw.Text(studentdata[index][total_a[i]],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        )),
      ]),
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(
            children: List.generate(
          obtainmarks_b.length,
          (i) => pw.Center(
            child: pw.Text(studentdata[index][obtainmarks_b[i]],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        )),
        pw.TableRow(
            children: List.generate(
          total_b.length,
          (i) => pw.Center(
            child: pw.Text(studentdata[index][total_b[i]],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        )),
      ]),
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(children: [
          pw.Center(
            child: pw.Text(studentdata[index]['total_ab'],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        ]),
        pw.TableRow(children: [
          pw.Center(
            child: pw.Text(studentdata[index]['all_total_ab'],
                style: pw.TextStyle(font: ttf, fontSize: 10)),
          ),
        ]),
      ]),
      pw.Center(
        child: pw.Text(studentdata[index]['grade'],
            style: pw.TextStyle(font: ttf, fontSize: 10)),
      ),
    ]);
  }

  var obtainmarks_a = [
    "daily_observation",
    "viva_a",
    "practical_activity",
    "activity",
    "project",
    "unit_test",
    "homework",
    "other",
    "total_a",
  ];

  var total_a = [
    "total_do",
    "total_viva_a",
    "total_practical_a",
    "total_activity_a",
    "total_project_a",
    "total_unit_test_a",
    "total_homework_a",
    "totol_other_a",
    "all_total_a"
  ];

  var obtainmarks_b = [
    "viva_b",
    "practical",
    "therotical",
    "total_b",
  ];

  var total_b = [
    "total_viva_b",
    "total_practical_b",
    "total_therotical_b",
    "all_total_b",
  ];

  var listofnumber = [
    '',
    '',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '',
    ''
  ];
  var resultbox = [
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
