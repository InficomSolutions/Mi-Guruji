import 'package:flutter/material.dart';

import '../../utils/images.dart';
import '../../widgets/back_button.dart';

class PDFView extends StatelessWidget {
  PDFView({Key? key,required this.title}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(title),
        centerTitle: true,
        elevation: 0.7,
      ),
      body: letterpadView(context),
    );
  }

  Widget letterpadView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
                top: 30,
                right: 20,
                child: Image.asset(Images.dummyLogo)),
            Positioned(
              top: 30,
              left: 20,
              child: SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inficom Solutions",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Mi Guru",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                width: 200,
                child: Text(
                  "V9QC+9C7, MIDC Industrial Area, Chilkalthana, Aurangabad, Maharashtra 431001",
                  style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
