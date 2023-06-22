import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/pages/homepage/plans_page.dart';
import 'package:techno_teacher/pages/welcome/welcome.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/utils/constants.dart';
import 'package:techno_teacher/widgets/dynamiclink.dart';

import 'getx_controller/student_info_controller/student_contorller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  var value = await Dynamiclinkprovider().initdynamiclink();
  Authcontroller().storerefferal("$value");
  FirebaseMessaging.instance.subscribeToTopic("all").whenComplete(() {
    FirebaseMessaging.onMessage.listen(backgroundHnadler);
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHnadler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future backgroundHnadler(RemoteMessage message) async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      title: AppConstants.appName,
      theme: ThemeData(
          textTheme: TextTheme(
        bodyText1:
            TextStyle(fontFamilyFallback: ["assets/fonts/Lohit-Marathi.ttf"]),
      )),
    );
  }
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Widget nextscreen = const WelcomePage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

//cheklogin token from mobile storage
  void checkLogin() async {
    var token = await Authcontroller().getToken();
    var checkexpiry = await Authcontroller().getexpirydate();
    if (token != null) {
      // if (checkexpiry == null) {
      var data = await subcribedplans(token);
      print(data);
      if (data.isEmpty) {
        setState(() {
          nextscreen = Planspage(
            token: token,
          );
        });
      } else {
        if (DateTime.parse("${data[0]['plan_expiry_date']}")
                .difference(DateTime.now())
                .inDays <=
            0) {
          setState(() {
            nextscreen = Planspage(
              token: token,
            );
          });
        } else {
          setState(() {
            Authcontroller().expirydate("${data[0]['plan_expiry_date']}");
            nextscreen = Homepage();
          });
        }
      }
      // } else {
      //   if (DateTime.parse("$checkexpiry").difference(DateTime.now()).inDays <=
      //       0) {
      //     setState(() {
      //       nextscreen = Planspage(
      //         token: token,
      //       );
      //     });
      //   } else {
      //     setState(() {
      //       nextscreen = Homepage();
      //     });
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: nextscreen,
    );
  }
}
