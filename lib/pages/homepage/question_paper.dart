import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

class Questionpaper extends StatefulWidget {
  const Questionpaper({super.key});

  @override
  State<Questionpaper> createState() => _QuestionpaperState();
}

class _QuestionpaperState extends State<Questionpaper> {
  allquestionpaper() async {
    var token = await Authcontroller().getToken();
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.questionpaper), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          questionpaperdata = res['data'];
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
    allquestionpaper();
    getusertotal();
  }

  @override
  Widget build(BuildContext context) {
    print(questionpaperdata);
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
            "वर्ग निहाय प्रश्नपत्रिका",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: questionpaperdata.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: questionpaperdata.length,
                itemBuilder: (BuildContext context, int index) {
                  var price =
                      double.parse(questionpaperdata[index]['rate']).toInt();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.35)),
                      child: Column(
                        children: [
                          Text(
                            questionpaperdata[index]['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "\u{20B9}$price",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "* " + questionpaperdata[index]['class'],
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "* " + questionpaperdata[index]['subject'],
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "* " + questionpaperdata[index]['language'],
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "* " + questionpaperdata[index]['year'],
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "* " + questionpaperdata[index]['season'],
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width / 3,
                            child: MaterialButton(
                              color: blackcolor,
                              onPressed: () {
                                var title =
                                    "${questionpaperdata[index]['title']}"
                                        .replaceAll("/", " ");
                                if (double.parse(
                                        "${questionpaperdata[index]['rate']}") <=
                                    0) {
                                  downloadpdf(
                                      context,
                                      "${TGuruJiUrl.url}/${questionpaperdata[index]['pdf']}",
                                      title);
                                } else {
                                  if (double.parse(usertotal) >=
                                      double.parse(
                                          "${questionpaperdata[index]['rate'] ?? 0.00}")) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => confirmationbox(
                                          context,
                                          amount: questionpaperdata[index]
                                              ['rate'], onpress: () {
                                        downloaddeduct(
                                                questionpaperdata[index]
                                                    ['rate'],
                                                questionpaperdata[index]
                                                    ['title'])
                                            .then((value) {
                                          getusertotal();
                                          downloadpdf(
                                              context,
                                              "${TGuruJiUrl.url}/${questionpaperdata[index]['pdf']}",
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
                              child: Text(
                                "डाउनलोड करा",
                                style:
                                    TextStyle(color: whitecolor, fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
