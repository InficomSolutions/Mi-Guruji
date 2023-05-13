import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Formlistpage extends StatefulWidget {
  const Formlistpage({super.key});

  @override
  State<Formlistpage> createState() => _FormlistpageState();
}

class _FormlistpageState extends State<Formlistpage> {
  getformdata() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.vivdhform), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          formdata = res['data'];
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
    // TODO: implement initState
    super.initState();
    getformdata();
    getuserbalance();
  }

  @override
  Widget build(BuildContext context) {
    print(formdata);
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
          "विविध फॉर्म",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: formdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.withOpacity(0.35)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            formdata[index]['title'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "₹" + formdata[index]['rate'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        var title =
                            "${formdata[index]['title']}".replaceAll("/", " ");
                        if (double.parse(
                                "${formdata[index]['rate'] ?? 0.00}") <=
                            0) {
                          downloadpdf(
                              context,
                              "${TGuruJiUrl.url}/${formdata[index]['pdf']}",
                              title);
                        } else {
                          if (double.parse(usertotal) >=
                              double.parse(
                                  "${formdata[index]['rate'] ?? 0.00}")) {
                            showDialog(
                              context: context,
                              builder: (context) => confirmationbox(context,
                                  amount: formdata[index]['rate'], onpress: () {
                                downloaddeduct(formdata[index]['rate'],
                                        formdata[index]['title'])
                                    .then((value) {
                                  getusertotal();
                                  downloadpdf(
                                      context,
                                      "${TGuruJiUrl.url}/${formdata[index]['pdf']}",
                                      title);
                                });
                              }),
                            );
                          } else {
                            Fluttertoast.showToast(msg: "Recharge Your Wallet");
                          }
                        }
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: blackcolor,
                            border: Border.all(color: whitecolor, width: 1.2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("डाउनलोड करा",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: whitecolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              Icon(
                                Icons.download,
                                color: whitecolor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
