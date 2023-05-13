import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/colors.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

class Sportrule extends StatefulWidget {
  const Sportrule({super.key});

  @override
  State<Sportrule> createState() => _SportruleState();
}

class _SportruleState extends State<Sportrule> {
  var rulesindex;
  bool isexpanded = false;
  getsportrules() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.sportrules), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          sportrules = res['data'];
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
    getsportrules();
  }

  @override
  Widget build(BuildContext context) {
    print(sportrules);
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
          "विविध खेळ नियमावली",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: sportrules.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // color: blackcolor,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/ground.jpg"
                          // "${TGuruJiUrl.url}${sportrules[index]['sport_image']}"
                          // "https://media.istockphoto.com/id/506692747/photo/artificial-grass.jpg?s=612x612&w=0&k=20&c=y5I6l-1MgmlPzf2DcEYX08dTLkUXgeo8PGa8Jv3EaOU="
                          ),
                      opacity: 1.9,
                      fit: BoxFit.fill),
                  border: Border.all(color: blackcolor),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      sportrules[index]['sport_name'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: whitecolor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  rulesindex == index
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "खेळाचा फोटो ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Image.network(
                                            "${TGuruJiUrl.url}${sportrules[index]['sport_image']}"),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "मैदानाचा फोटो",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Image.network(
                                            "${TGuruJiUrl.url}${sportrules[index]['ground_image']}"),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "प्रकार",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['sport_type']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "एकून खेळाडू ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['total_players']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "खेळाडू ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['sport_man']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "राखीव खेळाडू ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['reserve_players']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "मैदानाचा आकार ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['shape']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "खेळाचा वेळ ",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      ),
                                      Text(
                                        "->",
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 25),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          "${sportrules[index]['sport_duration']}",
                                          style: TextStyle(
                                              color: whitecolor, fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       SizedBox(
                                //         width:
                                //             MediaQuery.of(context).size.width /
                                //                 2,
                                //         child: Text(
                                //           "Charges",
                                //           style: TextStyle(
                                //               color: whitecolor, fontSize: 25),
                                //         ),
                                //       ),
                                //       Text(
                                //         "->",
                                //         style: TextStyle(
                                //             color: whitecolor, fontSize: 25),
                                //       ),
                                //       SizedBox(
                                //         width:
                                //             MediaQuery.of(context).size.width /
                                //                 4,
                                //         child: Text(
                                //           "${sportrules[index]['charges']}",
                                //           style: TextStyle(
                                //               color: whitecolor, fontSize: 25),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        rulesindex = isexpanded ? null : index;
                        isexpanded = !isexpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "नियम",
                          style: TextStyle(color: whitecolor, fontSize: 20),
                        ),
                        Icon(
                          isexpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: whitecolor,
                          size: 40,
                        )
                      ],
                    ),
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
