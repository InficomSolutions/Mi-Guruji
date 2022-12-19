import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: Homepage()),
      title: 'Techno Teacher',
    );
  }
}
