import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techno_teacher/pages/homepage/genratedpdf.dart';

Future<void> SaveAndLaunchFile(
    List<int> bytes, String filename, context) async {
  Directory? directory = await getExternalStorageDirectory();
  // final path = (await getExternalStorageDirectory())!.path;
  File file;
  String newPath = "";
  final List<String> paths = directory!.path.split("/");
  for (int x = 1; x < paths.length; x++) {
    final String folder = paths[x];
    if (folder != "Android") {
      newPath += "/$folder";
    } else {
      break;
    }
  }
  newPath = "$newPath/miguruji";
  directory = Directory(newPath);
  var status = await Permission.manageExternalStorage.status;

  while (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }

  if (!await directory.exists()) {
    directory.create();
  }

  if (await directory.exists()) {
    file = File("${directory.path}/$filename");

    await file.writeAsBytes(bytes);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${directory.path}/$filename")));
    Get.to(
      Generatedpdfview(
        filename: file,
      ),
    );
  }
  print(directory.path);
  // final file1 = File('${directory!.path}/$filename');
  // await file1.writeAsBytes(bytes, flush: true);
  // ScaffoldMessenger.of(context)
  //     .showSnackBar(SnackBar(content: Text("${directory.path}/$filename")));
  // Get.to(
  //   Generatedpdfview(
  //     filename: file1,
  //   ),
  // );
}
