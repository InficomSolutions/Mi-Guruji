import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/app_page.dart';
import 'package:techno_teacher/pages/homepage/blog_list.dart';
import 'package:techno_teacher/pages/homepage/latest_newspage.dart';
import 'package:techno_teacher/pages/homepage/teacher_info.dart';

class Technoteacher extends StatefulWidget {
  const Technoteacher({super.key});

  @override
  State<Technoteacher> createState() => _TechnoteacherState();
}

class _TechnoteacherState extends State<Technoteacher> {
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
            "Techno Teacher",
            style: TextStyle(
                color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => Teacherinfopage());
                },
                child: Stack(
                  children: [
                    Image.asset("assets/images/button33.png"),
                    Positioned(
                        top: MediaQuery.of(context).size.width / 8.7,
                        left: MediaQuery.of(context).size.width / 19,
                        child: Text(
                          "प्रेरक शिक्षक",
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Blogpage());
                },
                child: Stack(
                  children: [
                    Image.asset("assets/images/blog.png"),
                    Positioned(
                        top: MediaQuery.of(context).size.width / 8.7,
                        right: MediaQuery.of(context).size.width / 19,
                        child: Text(
                          "ब्लॉग यादी",
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Latestnewspage());
                },
                child: Stack(
                  children: [
                    Image.asset("assets/images/news.png"),
                    Positioned(
                        top: MediaQuery.of(context).size.width / 8.7,
                        left: MediaQuery.of(context).size.width / 19,
                        child: Text(
                          "ताज्या बातम्या",
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Apppage());
                },
                child: Stack(
                  children: [
                    Image.asset("assets/images/button2.png"),
                    Positioned(
                        top: MediaQuery.of(context).size.width / 8.7,
                        right: MediaQuery.of(context).size.width / 19,
                        child: Text(
                          "शैक्षणिक ॲप",
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
