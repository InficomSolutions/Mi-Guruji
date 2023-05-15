import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

class Examinfo extends StatefulWidget {
  const Examinfo({super.key});

  @override
  State<Examinfo> createState() => _ExaminfoState();
}

class _ExaminfoState extends State<Examinfo> {
  getexaminfo() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.examinfo), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          getexamdata = res['data'];
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  getuserbalance() async {
    var user = await getusertotal();
    setState(() {
      usertotal = user[0]["total_balance"];
      userdownloads = user[0]['total_downloads'];
    });
    print(user);
  }

  @override
  void initState() {
    super.initState();
    getexaminfo();
    getuserbalance();
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
          "वर्गनिहाय परीक्षा माहिती",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: getexamdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.35)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          getexamdata[index]['exam_name'],
                          style: TextStyle(color: blackcolor, fontSize: 25),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Colors.blue,
                            ])),
                        child: Text(
                          '\u{20B9}${getexamdata[index]['rate']}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: whitecolor),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getexamdata[index]['description'],
                    style: TextStyle(color: blackcolor, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          var title = "${getexamdata[index]['exam_name']}"
                              .replaceAll("/", " ");
                          if (double.parse(
                                  "${getexamdata[index]['rate'] ?? 0.00}") <=
                              0) {
                            downloadpdf(
                                context,
                                "${TGuruJiUrl.url}/${getexamdata[index]['exam_form']}",
                                title);
                          } else {
                            if (double.parse(usertotal ?? 0) >=
                                double.parse(
                                    "${getexamdata[index]['rate'] ?? 0.00}")) {
                              showDialog(
                                context: context,
                                builder: (context) => confirmationbox(context,
                                    amount: getexamdata[index]['rate'],
                                    onpress: () {
                                  downloaddeduct(getexamdata[index]['rate'],
                                          getexamdata[index]['exam_name'])
                                      .then((value) {
                                    getusertotal();
                                    downloadpdf(
                                        context,
                                        "${TGuruJiUrl.url}/${getexamdata[index]['exam_form']}",
                                        title);
                                  });
                                }),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Recharge Your Wallet");
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: blackcolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: blackcolor)
                              // gradient: LinearGradient(
                              //     colors: [Colors.deepOrange, Colors.yellow])
                              ),
                          child: Text(
                            'डाउनलोड करा',
                            style: TextStyle(fontSize: 25, color: whitecolor),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Icon(Icons.close),
                                          )),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.3,
                                      child: SfPdfViewer.network(
                                          "${TGuruJiUrl.url}${getexamdata[index]['exam_form']}"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: blackcolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: blackcolor)
                              // gradient: LinearGradient(
                              //     colors: [Colors.deepOrange, Colors.yellow])
                              ),
                          child: Text(
                            'PDF बघा',
                            style: TextStyle(fontSize: 25, color: whitecolor),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
