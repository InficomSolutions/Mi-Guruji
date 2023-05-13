import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'complete_page.dart';

class Latestnewspage extends StatefulWidget {
  const Latestnewspage({super.key});

  @override
  State<Latestnewspage> createState() => _LatestnewspageState();
}

class _LatestnewspageState extends State<Latestnewspage> {
  getnews() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.latestnews), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          newsdata = res['data'];
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
    getnews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: blackcolor,
        iconTheme: IconThemeData(
          color: whitecolor,
        ),
        elevation: 0.7,
        centerTitle: true,
        title: Text(
          "ताज्या बातम्या",
          style: TextStyle(
              color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: blogdata.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: blackcolor,
              onRefresh: () async {
                getnews();
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: newsdata.length,
                itemBuilder: (BuildContext context, int index) {
                  var description = parse(newsdata[index]['description']);
                  var date = DateTime.parse(newsdata[index]['news_date']);
                  print(date);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => Completepage(
                              title: newsdata[index]['news_title'],
                              description: description.body!.text,
                              image: TGuruJiUrl.url + newsdata[index]['image'],
                              link: newsdata[index]['video_link'],
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            // color: bluecolor,
                            border: Border.all(color: blackcolor),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                    "${date.day}/${date.month}/${date.year}"),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  newsdata[index]['news_title'],
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                h(10),
                                Image.network(
                                  TGuruJiUrl.url + newsdata[index]['image'],
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                                h(10),
                                Text(
                                  description.body!.text.length < 150
                                      ? description.body!.text
                                      : description.body!.text
                                          .substring(0, 150),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "अधिक वाचा",
                                      style: TextStyle(
                                          color: redcolor, fontSize: 20),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: redcolor,
                                    )
                                  ],
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
            ),
    ));
  }
}
