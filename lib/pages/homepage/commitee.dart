import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

class Commitee extends StatefulWidget {
  const Commitee({super.key});

  @override
  State<Commitee> createState() => _CommiteeState();
}

class _CommiteeState extends State<Commitee> {
  getcommitee() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.commitee), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          commiteedata = res['data'];
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
    getcommitee();
    getuserbalance();
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
          "विविध समित्या",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: commiteedata.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.35)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        color: redcolor,
                        size: 50,
                      ),
                      w(5),
                      Expanded(
                        child: Text(
                          commiteedata[index]['title'],
                          style: TextStyle(color: blackcolor, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Colors.blue,
                            ])),
                        child: Text(
                          '\u{20B9}${commiteedata[index]['rate']}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      progress == true
                          ? downloadindex == index
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                var title = "${commiteedata[index]['title']}"
                                    .replaceAll("/", " ");
                                if (double.parse(
                                        "${commiteedata[index]['rate'] ?? 0.00}") <=
                                    0) {
                                  setState(() {
                                    progress = true;
                                    downloadindex = index;
                                  });
                                  downloadpdf(
                                          context,
                                          "${TGuruJiUrl.url}/${commiteedata[index]['pdf']}",
                                          title)
                                      .then((value) {
                                    setState(() {
                                      progress = false;
                                    });
                                  });
                                } else {
                                  if (double.parse(usertotal ?? 0) >=
                                      double.parse(
                                          "${commiteedata[index]['rate'] ?? 0.00}")) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => confirmationbox(
                                          context,
                                          amount: commiteedata[index]['rate'],
                                          onpress: () {
                                        downloaddeduct(
                                                commiteedata[index]['rate'],
                                                commiteedata[index]['title'])
                                            .then((value) {
                                          Navigator.pop(context);
                                          getusertotal();
                                          setState(() {
                                            progress = true;
                                            downloadindex = index;
                                          });
                                          downloadpdf(
                                                  context,
                                                  "${TGuruJiUrl.url}/${commiteedata[index]['pdf']}",
                                                  title)
                                              .then((value) {
                                            setState(() {
                                              progress = false;
                                            });
                                          });
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
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Colors.deepOrange,
                                      Colors.yellow
                                    ])),
                                child: Text(
                                  'डाउनलोड करा',
                                  style: TextStyle(fontSize: 25),
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
