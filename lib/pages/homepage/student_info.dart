import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/pages/student_info/student_detail_form.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/utils/constants.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Studentinfo extends StatefulWidget {
  const Studentinfo({super.key});

  @override
  State<Studentinfo> createState() => _StudentinfoState();
}

class _StudentinfoState extends State<Studentinfo> {
  final StudentController _controller = Get.put(StudentController());

  getstudentdata() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.student), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          studentdata = res['data'];
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
    getstudentdata();
  }

  getfont() async {
    final font = await rootBundle.load("assets/fonts/Lohit-Marathi.ttf");
    ttffont = pw.Font.ttf(font);
  }

  clearthevalue() {
    _controller.adhaar.value.clear();
    _controller.schoolName.value.clear();
    _controller.studentclass.value.clear();
    _controller.mobilenumber.value.clear();
    _controller.ifsc.value.clear();
    _controller.bankAccount.value.clear();
    _controller.name.value.clear();
    _controller.schoolName.value.clear();
    _controller.cast.value.clear();
    _controller.dob.value.clear();
    _controller.downloads.value.clear();
    _controller.minority.value.clear();
    _controller.mothername.value.clear();
    _controller.studentID.value.clear();
    _controller.parentIncome.value.clear();
    _controller.handicapType.value.clear();
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
          "वर्ग निहाय विद्यार्थी यादी",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          InkWell(
              onTap: () {
                clearthevalue();
                Get.to(() => StudentInfo(
                      valueavailable: false,
                      studentvalue: null,
                    ));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        color: blackcolor,
        onRefresh: () async {
          getstudentdata();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "वर्ग निहाय विद्यार्थी माहिती",
                style: TextStyle(color: blackcolor, fontSize: 30),
              ),
            ),
            InkWell(
              onTap: () {
                // _createpdf();
                createpdf();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: bluecolor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: blackcolor)
                    // gradient: LinearGradient(
                    //     colors: [Colors.deepOrange, Colors.yellow])
                    ),
                child: Text(
                  'पीडीएफ डाउनलोड करा',
                  style: TextStyle(fontSize: 25, color: whitecolor),
                ),
              ),
            ),
            Divider(
              color: blackcolor,
            ),
            Text(
              "विद्यार्थी माहिती खालीलप्रमाणे ",
              textScaleFactor: 1.5,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: studentdata.length,
                itemBuilder: (BuildContext context, int index) {
                  print(studentdata);
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentdata[index]['student_name'],
                              ),
                              Row(
                                children: [
                                  Text("वर्ग:- "),
                                  Text(
                                    studentdata[index]['class'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => StudentInfo(
                                      valueavailable: true,
                                      studentvalue: studentdata[index],
                                    ));
                              },
                              child: Icon(Icons.edit)),
                          // DropdownButton(
                          //   icon: const Icon(Icons.more_vert),
                          //   items: const [
                          //     DropdownMenuItem(
                          //       value: 'edit',
                          //       child: Text("Edit"),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 'delete',
                          //       child: Text("Delete"),
                          //     )
                          //   ],
                          //   onChanged: (value) {
                          //     if (value == 'delete') {
                          //     } else if (value == 'edit') {

                          //     }
                          //   },
                          // ),
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

  var tablebox = [
    'अनुक्रमांक',
    'विध्यार्थ्यांचे संपूर्ण नाव',
    'वर्ग',
    'आईचे नाव',
    'जात व संवर्ग',
    'जन्मदिनांक',
    'स्टुडंट आय डी',
    'आधार क्रमांक',
    'बँक खाते क्रमांक',
    'आय.एफ.एस.सी. कोड',
    'प्पालकांचे वार्षिक उत्पन्न',
    'अल्पसंख्यांक धर्म',
    'विशेष गरजा असल्यास अपंगत्व प्रकार',
    'पालक मोबाईल क्रमांक',
  ];
  var rowlist = [
    "user_id",
    "student_name",
    "class",
    "mother_name",
    "cast",
    "dob",
    "student_id",
    "adhar_no",
    "bank_account_num",
    'ifsc_code',
    "parent_income",
    "minority",
    "handicap_type",
    "mobile_num",
  ];
  createpdf() async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Lohit-Marathi.ttf");
    downloadcount();
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pw.Table(border: pw.TableBorder.all(), children: [
            pw.TableRow(
                children: List.generate(
              tablebox.length,
              (index) => pw.FittedBox(
                  child: pw.Padding(
                padding: pw.EdgeInsets.all(8),
                child: pw.Text(tablebox[index],
                    style: pw.TextStyle(
                      font: ttf,
                    )),
              )),
            )),
            ...List.generate(
              studentdata.length,
              (index) => pw.TableRow(
                  children: List.generate(
                rowlist.length,
                (i) => pw.FittedBox(
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                              i == 0
                                  ? '${index + 1}'
                                  : "${studentdata[index][rowlist[i]]}",
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(
                                  fontFallback: [ttf], fontSize: 10)),
                        ))),
              )),
            )
          ])
        ];
        // return pw.Text('अनुक्रमांक',
        //     style: pw.TextStyle(
        //       font: ttf,
        //     ));
      },
    ));
    List<int> bytes = await pdf.save();
    SaveAndLaunchFile(bytes, 'output.pdf', context);
  }
}
