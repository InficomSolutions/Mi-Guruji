import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/exams/exam_page.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';

import '../../widgets/back_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text('विविध फॉर्म '),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                toScreen(context, const ExamPage());
              },
              child: Image.asset(Images.details),
            ),
          ),
        ),
      ),
    );
  }
}
