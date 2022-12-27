import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/pages/welcome/welcome.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      title: AppConstants.appName,
      theme: light,
    );
  }
}
