import 'package:flutter/material.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/widgets/back_button.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class ExamPage extends StatefulWidget {
   ExamPage({Key? key,required this.title}) : super(key: key);
  String title;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        title: Text(widget.title),
        centerTitle: true,
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(Images.examSheet),
              h(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomButton(
                  onPressed: () {},
                  text: 'Download',
                  fullWidth: true,
                  bgColor: Colors.black,
                  fgColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
