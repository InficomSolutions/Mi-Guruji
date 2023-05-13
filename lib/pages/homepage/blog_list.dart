import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/complete_page.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Blogpage extends StatefulWidget {
  const Blogpage({super.key});

  @override
  State<Blogpage> createState() => _BlogpageState();
}

class _BlogpageState extends State<Blogpage> {
  myBlogs() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.blog), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          blogdata = res['data'];
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
    myBlogs();
  }

  final _random = Random();
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
          "ब्लॉग यादी",
          style: TextStyle(
              color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: blogdata.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: blogdata.length,
              itemBuilder: (BuildContext context, int index) {
                var description = parse(blogdata[index]['description']);
                var date = DateTime.parse(blogdata[index]['created_at']);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => Completepage(
                            title: blogdata[index]['blogs_name'],
                            description: description.body!.text,
                            image: TGuruJiUrl.url + blogdata[index]['image'],
                            link: blogdata[index]['blog_link'],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      blogdata[index]['blogs_name'],
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    h(10),
                                    Text(
                                      description.body!.text.substring(0, 150),
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    TGuruJiUrl.url + blogdata[index]['image'],
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  )),
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
    ));
  }
}
