import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/welcome/welcome.dart';
import 'package:techno_teacher/theme/light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: WelcomePage()),
      title: 'Techno Teacher',
      theme: light,
    );
  }
}
