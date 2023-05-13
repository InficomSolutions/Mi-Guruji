import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/pages/homepage/complete_page.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api_utility/cont_urls.dart';
import '../../utils/snackbar/custom_snsckbar.dart';

class Teacherinfopage extends StatefulWidget {
  const Teacherinfopage({super.key});

  @override
  State<Teacherinfopage> createState() => _TeacherinfopageState();
}

class _TeacherinfopageState extends State<Teacherinfopage> {
  getteacherdataa() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.teacherdata), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          teacherdata = res['data'];
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
    getteacherdataa();
  }

  @override
  Widget build(BuildContext context) {
    print(teacherdata);
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
          "प्रेरक शिक्षक",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: teacherdata.length,
        itemBuilder: (BuildContext context, int index) {
          var description = parse(teacherdata[index]['description']);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${teacherdata[index]['teacher_name']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                "${teacherdata[index]['school_name']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Image.network(
                          teacherdata[index]['category_image'] != null
                              ? "${TGuruJiUrl.url}${teacherdata[index]['category_image']}"
                              : "https://www.shutterstock.com/image-vector/man-icon-vector-260nw-1040084344.jpg",
                          width: 50,
                          height: 100,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "संपर्क :-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        w(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      'tel:=${teacherdata[index]['mobile']}'));
                                },
                                child: Icon(Icons.phone)),
                            w(10),
                            InkWell(
                              onTap: () {
                                var url = Uri.parse(
                                    "whatsapp://send?phone=${teacherdata[index]['whatsapp_link']}");
                                launchUrl(url);
                              },
                              child: Image.network(
                                "https://img.icons8.com/color/512/whatsapp--v1.png",
                                width: 35,
                              ),
                            ),
                            w(10),
                            InkWell(
                              onTap: () {
                                var url = Uri.parse(
                                    "${teacherdata[index]['insta_link']}");
                                launchUrl(url);
                              },
                              child: Image.network(
                                "https://cdn.icon-icons.com/icons2/1211/PNG/512/1491579602-yumminkysocialmedia36_83067.png",
                                width: 25,
                              ),
                            ),
                            w(10),
                            InkWell(
                              onTap: () {
                                var url = Uri.parse(
                                  "${teacherdata[index]['fb_link']}",
                                );
                                launchUrl(url);
                              },
                              child: Image.network(
                                "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
                                width: 25,
                              ),
                            ),
                            w(10),
                            InkWell(
                              onTap: () {
                                var url = Uri.parse(
                                  "${teacherdata[index]['youtube']}",
                                );
                                launchUrl(url);
                              },
                              child: Image.network(
                                "https://w7.pngwing.com/pngs/1009/93/png-transparent-youtube-computer-icons-logo-youtube-angle-social-media-share-icon.png",
                                width: 30,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      description.body!.text.length < 150
                          ? description.body!.text
                          : description.body!.text.substring(0, 150),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => Completepage(
                                title: teacherdata[index]['teacher_name'],
                                description: description.body!.text,
                                image: TGuruJiUrl.url +
                                    teacherdata[index]['category_image'],
                                link: teacherdata[index]['fb_link'],
                              ));
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "अधिक वाचा",
                                style: TextStyle(color: redcolor, fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: redcolor,
                              )
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
