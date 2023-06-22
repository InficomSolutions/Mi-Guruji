import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  int apiLevel = androidInfo.version.sdkInt;
  print(apiLevel);
  if (apiLevel < 29) {
    newPath = "$newPath/miguruji";
  } else {
    newPath = "$newPath/Download";
  }
  directory = Directory(newPath);
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }

  if (!await directory.exists()) {
    directory.create();
  }

  file = File("${directory.path}/$filename");

  await file.writeAsBytes(bytes);
  Fluttertoast.showToast(msg: "${directory.path}/$filename");
  Get.to(
    Generatedpdfview(
      filename: file,
    ),
  );

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
