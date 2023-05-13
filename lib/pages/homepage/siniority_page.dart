import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sy;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/add_seniority.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/pages/homepage/genratedpdf.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Senioritypage extends StatefulWidget {
  const Senioritypage({super.key});

  @override
  State<Senioritypage> createState() => _SenioritypageState();
}

class _SenioritypageState extends State<Senioritypage> {
  getsinoritydata() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.getseniority), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          sinoritydata = res['data'];
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
    getsinoritydata();
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
          "सेवाजेष्ठता यादी",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(AddSeniority(
                  data: null,
                ));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        color: blackcolor,
        onRefresh: () async {
          getsinoritydata();
        },
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "Generate Date In pdf",
            //     style: TextStyle(color: blackcolor, fontSize: 30),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
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
                    'डाऊनलोड करा',
                    style: TextStyle(fontSize: 25, color: whitecolor),
                  ),
                ),
              ),
            ),
            Divider(
              color: blackcolor,
            ),
            Text(
              "माहिती खालीलप्रमाणे",
              textScaleFactor: 1.5,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sinoritydata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.35)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(sinoritydata[index]['full_name']),
                              Text(sinoritydata[index]['mobile_num']),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => AddSeniority(
                                          data: sinoritydata[index],
                                        ));
                                  },
                                  child: Icon(Icons.edit)),
                            ],
                          ),
                          Text(sinoritydata[index]['retirement_date']),
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
    'शिक्षकाचे संपूर्ण नाव',
    'मोबाईल क्रमांक',
    'पदनाम',
    'वेतनश्रेणी',
    'बेसिक',
    'जात संवर्ग व जात',
    'जन्म दिनांक',
    'प्रथम नेमणूक दिनांक',
    'या शाळेवर नियुक्ती दिनांक',
    'या तालुक्यातील नियुक्ती दिनांक',
    'पती पत्नी सेवेत आहेत काय',
    'व्यावसायिक पात्रता',
    'शैक्षणिक पात्रता',
    'आंतरजिल्हा उपस्थिती दिनांक',
    'सेवानिवृत्त दिनांक',
    'अध्यापन वर्ग व विषय',
  ];
  var rowlist = [
    "user_id",
    "full_name",
    "mobile_num",
    "post_name",
    "salary",
    "basic",
    "cast",
    "minority",
    "joined_date",
    "present_school_joined_date",
    "taluka_joined_date",
    "partner_in_service",
    "location",
    "business_qualification",
    "education",
    "dist_present_date",
    "retirement_date",
    "teaching_class",
    "subject",
    "status",
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
              sinoritydata.length,
              (index) => pw.TableRow(
                  children: List.generate(
                rowlist.length,
                (i) => pw.FittedBox(
                    child: pw.Padding(
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Text(sinoritydata[index][rowlist[i]],
                      style: pw.TextStyle(
                        fontFallback: [ttf],
                      )),
                )),
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
