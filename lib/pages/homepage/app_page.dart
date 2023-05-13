import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Apppage extends StatefulWidget {
  const Apppage({super.key});

  @override
  State<Apppage> createState() => _ApppageState();
}

class _ApppageState extends State<Apppage> {
  getapp() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.educationalapp), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          appdata = res['data'];
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
    // TODO: implement initState
    super.initState();
    getapp();
  }

  @override
  Widget build(BuildContext context) {
    print(appdata);
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
          "शैक्षणिक ॲप",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [],
      ),
      body: appdata == null
          ? SizedBox()
          : ListView.builder(
              itemCount: appdata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: blackcolor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              "https://images.hindustantimes.com/tech/img/2021/02/06/960x540/Google_Play_Store_1604915225234_1604915250668_1612617713151.jpg",
                              width: 70,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appdata[index]['app_name'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(appdata[index]['description'])
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              final Uri _url =
                                  Uri.parse('${appdata[index]['app_link']}');
                              launchUrl(_url);
                            },
                            child: Icon(
                              Icons.launch,
                              color: redcolor,
                              size: 40,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
