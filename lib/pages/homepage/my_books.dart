import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/theme/light.dart';
import '../../api_utility/cont_urls.dart';
import '../../utils/snackbar/custom_snsckbar.dart';
import '../../widgets/sizedbox.dart';

class MyBooks extends StatefulWidget {
  MyBooks({Key? key}) : super(key: key);

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  var searched = [];
  var classvalue;
  var subject;

  final StudentController _controller = Get.put(StudentController());
  myBooks() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.booklist), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          bookdata = res['data'];
        });
        sepratedata();
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

  searchaccording() {
    searched.clear();
    for (int i = 0; i < bookdata.length; i++) {
      if (classvalue != null && subject != null) {
        if (bookdata[i]['class_name'] == classvalue &&
            bookdata[i]['language'] == subject) {
          setState(() {
            searched.add(bookdata[i]);
          });
        }
      } else if (classvalue != null && subject == null) {
        if (bookdata[i]['class_name'] == classvalue) {
          setState(() {
            searched.add(bookdata[i]);
          });
        }
      } else if (classvalue == null && subject != null) {
        if (bookdata[i]['language'] == subject) {
          setState(() {
            searched.add(bookdata[i]);
          });
        }
      }
    }
  }

  sepratedata() {
    totalclass.clear();
    totalsubject.clear();
    for (int i = 0; i < bookdata.length; i++) {
      if (totalclass.contains(bookdata[i]['class_name']) == false) {
        setState(() {
          totalclass.add(bookdata[i]['class_name']);
        });
      }
      if (totalsubject.contains(bookdata[i]['language']) == false) {
        setState(() {
          totalsubject.add(bookdata[i]['language']);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myBooks();
    getusertotal();
    if (bookdata.isNotEmpty) {
      sepratedata();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(searched);
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
          "वर्गनिहाय पाठ्यपुस्तके",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: bookdata.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PopupMenuButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          classvalue ?? "ALL",
                                          style: TextStyle(
                                              color: blackcolor, fontSize: 25),
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    classvalue = value;
                                  });
                                  searchaccording();
                                },
                                // initialValue: classvalue,
                                itemBuilder: (context) {
                                  return List.generate(
                                      totalclass.length,
                                      (index) => PopupMenuItem(
                                          value: totalclass[index],
                                          child: Text(totalclass[index])));
                                },
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      classvalue = null;
                                      searched = [];
                                    });
                                    searchaccording();
                                  },
                                  child: Icon(Icons.close))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PopupMenuButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          subject ?? "ALL",
                                          style: TextStyle(
                                              color: blackcolor, fontSize: 25),
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    subject = value;
                                  });
                                  searchaccording();
                                },
                                // initialValue: subject,
                                itemBuilder: (context) {
                                  return List.generate(
                                      totalsubject.length,
                                      (index) => PopupMenuItem(
                                          value: totalsubject[index],
                                          child: Text(totalsubject[index])));
                                },
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      subject = null;
                                      searched = [];
                                    });
                                    searchaccording();
                                  },
                                  child: Icon(Icons.close))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: classvalue != null || subject != null
                      ? searched.length
                      : bookdata.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var activelist = classvalue != null || subject != null
                        ? searched
                        : bookdata;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/boardd.png",
                              ),
                              fit: BoxFit.fill)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: MediaQuery.of(context).size.width / 9.8,
                            top: MediaQuery.of(context).size.width / 7.8,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${activelist[index]['language']}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25)),
                                  Text(
                                      "वर्ग : ${activelist[index]['class_name']}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          h(15),
                          Positioned(
                            // left: MediaQuery.of(context).size.width / 5,
                            top: MediaQuery.of(context).size.width / 4.2,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text("${activelist[index]['book_name']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                            ),
                          ),
                          h(15),
                          Positioned(
                            bottom: MediaQuery.of(context).size.width / 19,
                            right: MediaQuery.of(context).size.width / 13,
                            child: InkWell(
                              onTap: () {
                                print(activelist);
                                var title = "${activelist[index]['book_name']}"
                                    .replaceAll("/", " ");
                                if (double.parse(
                                        "${activelist[index]['rate'] ?? 0.00}") <=
                                    0) {
                                  downloadpdf(
                                      context,
                                      "${TGuruJiUrl.url}/${activelist[index]['link']}",
                                      title);
                                } else {
                                  if (double.parse(usertotal ?? 0) >=
                                      double.parse(
                                          "${activelist[index]['rate'] ?? 0.00}")) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => confirmationbox(
                                          context,
                                          amount: activelist[index]['rate'],
                                          onpress: () {
                                        downloaddeduct(
                                                activelist[index]['rate'],
                                                title)
                                            .then((value) {
                                          getusertotal();
                                          downloadpdf(
                                              context,
                                              "${TGuruJiUrl.url}/${activelist[index]['link']}",
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
                                // width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: blackcolor,
                                    border: Border.all(
                                        color: whitecolor, width: 1.2),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("पुस्तक डाउनलोड करा",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
