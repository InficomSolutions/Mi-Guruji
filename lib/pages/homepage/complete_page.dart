import 'package:flutter/material.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:url_launcher/url_launcher.dart';

class Completepage extends StatefulWidget {
  var description;
  var image;
  var link;
  var title;
  Completepage(
      {super.key, this.description, this.image, this.link, this.title});

  @override
  State<Completepage> createState() => _CompletepageState();
}

class _CompletepageState extends State<Completepage> {
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
        ),
        body: SingleChildScrollView(
          child: InkWell(
            onTap: () {
              launchUrl(Uri.parse(widget.link));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blackcolor, fontSize: 25),
                  ),
                ),
                h(5),
                Image.network(widget.image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: blackcolor, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
