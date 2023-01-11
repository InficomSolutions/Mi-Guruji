import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class LetterPadView extends StatelessWidget {
  LetterPadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          pdfView(),
        ],
      ),
    );
  }

  //style: TextStyle(fontSize: 30,color: Colors.black)

  Widget pdfView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          h(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Establistment : 1930",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Text(
                    "School Mandal Number : MO862007",
                    style: TextStyle(fontSize: 09, color: Colors.black),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Udayan No .: 27280601001",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Text(
                    "S.S.C.Board Index : 62.05.06",
                    style: TextStyle(fontSize: 9, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
          h(30),
          const Center(
              child: Text(
            "ZILLA PARISHAD PRASHALA, BOROAL",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          h(4),
          const Center(
              child: Text(
            "Ta devdi Latoor(Maharastra)",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
          )),
          h(10),
          Divider(
            thickness: 4,
            color: Colors.black,
            height: 5,
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
            height: 5,
          ),
          h(13),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("No. : "),
              Text("Date :   /   /20  "),
            ],
          )
        ],
      ),
    );
  }
}
