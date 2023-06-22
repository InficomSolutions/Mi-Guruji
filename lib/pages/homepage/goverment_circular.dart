import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import '../../api_utility/cont_urls.dart';
import '../../utils/snackbar/custom_snsckbar.dart';

class Govermentcircular extends StatefulWidget {
  const Govermentcircular({super.key});

  @override
  State<Govermentcircular> createState() => _GovermentcircularState();
}

class _GovermentcircularState extends State<Govermentcircular> {
  mycircular() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.govermentcircular), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        setState(() {
          govermentcirculardata = res['data'];
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
    mycircular();
    getusertotal();
  }

  bool progress = false;
  var downloadindex;
  @override
  Widget build(BuildContext context) {
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
          "विविध शासकीय परिपत्रके",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: govermentcirculardata.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: govermentcirculardata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: blackcolor))),
                    child: Column(
                      children: [
                        Text(
                          govermentcirculardata[index]['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: MaterialButton(
                                color: blackcolor,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.3,
                                              child: SfPdfViewer.network(
                                                  "${TGuruJiUrl.url}${govermentcirculardata[index]['pdf']}"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  print("object");
                                },
                                child: Text(
                                  "PDF बघा",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 25),
                                ),
                              ),
                            ),
                            progress == true
                                ? downloadindex == index
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : SizedBox.shrink()
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: MaterialButton(
                                      color: blackcolor,
                                      onPressed: () {
                                        var title =
                                            "${govermentcirculardata[index]['title']}"
                                                .replaceAll("/", " ");
                                        if (double.parse(
                                                "${govermentcirculardata[index]['rate'] ?? 0.00}") <=
                                            0) {
                                          setState(() {
                                            progress = true;
                                            downloadindex = index;
                                          });
                                          downloadpdf(
                                                  context,
                                                  "${TGuruJiUrl.url}/${govermentcirculardata[index]['pdf']}",
                                                  title)
                                              .then((value) {
                                            setState(() {
                                              progress = false;
                                            });
                                          });
                                        } else {
                                          if (double.parse(usertotal ?? 0) >=
                                              double.parse(
                                                  "${govermentcirculardata[index]['rate'] ?? 0.00}")) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  confirmationbox(
                                                      context,
                                                      amount:
                                                          govermentcirculardata[
                                                              index]['rate'],
                                                      onpress: () {
                                                downloaddeduct(
                                                        govermentcirculardata[
                                                            index]['rate'],
                                                        govermentcirculardata[
                                                            index]['title'])
                                                    .then((value) {
                                                       Navigator.pop(context);
                                                  getusertotal();
                                                  setState(() {
                                                    progress = true;
                                                    downloadindex = index;
                                                  });
                                                  downloadpdf(
                                                          context,
                                                          "${TGuruJiUrl.url}/${govermentcirculardata[index]['pdf']}",
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
                                      child: Text(
                                        "डाउनलोड करा",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹" + govermentcirculardata[index]['rate'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                    "तारीख:-  ${govermentcirculardata[index]['created_at']}"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    ));
  }
}
