import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/exams/exam_page.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';

import '../../widgets/back_button.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollController = ScrollController();

  List<String> textList = [
    "उपयोगिता प्रमाणपत्र",
    "कार्यमुक्त प्रमाणपत्र नमुनार",
    "जिला शैक्षिक सत्वपूर्ण व्यवसायिक विकास",
    "पगार पत्रक",
    "वास्तविक प्रमाण पत्र",
    "चिकित्सा प्रमाण पत्र",
    "शैल्या पोषण आहार",
    "उपस्थति आहवाल",
    "खर्चे विवरन",
    "निर्गम उतारा",
    "वार्शिक उत्पन्याचे विवरन",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: list(),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: textList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: InkWell(
            onTap: () {
              toScreen(context,  ExamPage(title: textList[index]));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey.withOpacity(0.35)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                child: Text(
                  textList[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
