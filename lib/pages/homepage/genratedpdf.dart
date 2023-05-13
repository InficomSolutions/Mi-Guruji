import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:techno_teacher/colors.dart';

class Generatedpdfview extends StatefulWidget {
  var filename;
  Generatedpdfview({Key? key, this.filename}) : super(key: key);

  @override
  State<Generatedpdfview> createState() => _GeneratedpdfviewState();
}

class _GeneratedpdfviewState extends State<Generatedpdfview> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whitecolor,
        automaticallyImplyLeading: false,
        title: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: blackcolor,
            )),
      ),
      body: SfPdfViewer.file(
        widget.filename,
        key: _pdfViewerKey,
      ),
    );
  }
}
