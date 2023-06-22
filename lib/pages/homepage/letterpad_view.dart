import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:pdf/widgets.dart' as pw;

class LetterPadView extends StatefulWidget {
  LetterPadView({Key? key}) : super(key: key);

  @override
  State<LetterPadView> createState() => _LetterPadViewState();
}

class _LetterPadViewState extends State<LetterPadView> {
  StudentController _studentController = Get.put(StudentController());
  bool downloading = false;
  final ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    // DateTime date = DateTime.parse(latterpaddata[0]['foundation_year']);
    print(latterpaddata[0]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whitecolor,
          ),
          backgroundColor: blackcolor,
          elevation: 0.7,
          centerTitle: true,
          title: const Text(
            "शाळा लेटरपॅड",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            pdfView(date, context),
            const SizedBox(height: 20),
            downloading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () async {
                      setState(() {
                        downloading = true;
                      });
                      downloadcount();
                      final Uint8List image = await controller
                          .captureFromWidget(pdfView(date, context),
                              context: context);
                      final pdf = pw.Document();
                      pdf.addPage(pw.Page(build: (pw.Context context) {
                        final im = pw.MemoryImage(image);
                        return pw.Center(
                          child: pw.Image(im),
                        ); // Center
                      }));

                      List<int> bytes = await pdf.save();
                      Fluttertoast.showToast(msg: "Saving pdf");
                      SaveAndLaunchFile(bytes, 'letterpad.pdf', context);
                      setState(() {
                        downloading = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.deepOrange, Colors.blue]),
                            border: Border.all(color: blackcolor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "लेटरपॅड डाउनलोड करा",
                          style: TextStyle(
                            color: whitecolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  //style: TextStyle(fontSize: 30,color: leterpadcolor)
  Widget pdfView(var date, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: leterpadcolor)),
        padding: const EdgeInsets.all(8.0),
        child: latterpaddata[0] == null
            ? Center(
                child: Text("No Data Found"),
              )
            : Column(
                children: [
                  h(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "स्थापना ${latterpaddata[0]['foundation_year']}",
                              style:
                                  TextStyle(fontSize: 12, color: leterpadcolor),
                            ),
                            Text(
                              "शाळा मंडळ क्रमांक : ${latterpaddata[0]['center_no']}",
                              style:
                                  TextStyle(fontSize: 12, color: leterpadcolor),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "युडायस क्र. : ${latterpaddata[0]['udais_no']}",
                              style:
                                  TextStyle(fontSize: 12, color: leterpadcolor),
                            ),
                            Text(
                              "एस.एस.सी. बोर्ड सांकेतांक: ${latterpaddata[0]['Index_no']}",
                              style:
                                  TextStyle(fontSize: 12, color: leterpadcolor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  h(30),
                  Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "${latterpaddata[0]['school_name']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: leterpadcolor),
                      ),
                    ),
                  )),
                  h(4),
                  Center(
                      child: Text(
                    "${latterpaddata[0]['address']}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: leterpadcolor),
                  )),
                  h(10),
                  Divider(
                    thickness: 4,
                    color: leterpadcolor,
                    height: 5,
                  ),
                  Divider(
                    thickness: 2,
                    color: leterpadcolor,
                    height: 5,
                  ),
                  h(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "जा. क्र. : ",
                        style: TextStyle(color: leterpadcolor),
                      ),
                      Text("दिनांक :     /     /20    ",
                          style: TextStyle(color: leterpadcolor)),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
