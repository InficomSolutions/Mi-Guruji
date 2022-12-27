import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/pages/register/register.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(Images.welcome),
            h(30),
            Column(
              children: [
                CustomButton(
                  onPressed: () {
                    toScreen(context, const LoginPage());
                  },
                  text: 'Login',
                  fullWidth: true,
                  bgColor: Colors.black,
                  fgColor: Colors.white,
                ),
                h(20),
                CustomButton(
                  onPressed: () {
                    toScreen(context, RegisterPage());
                  },
                  text: 'Register',
                  fullWidth: true,
                  borderColor: Colors.black,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                replaceScreen(context, const Homepage());
              },
              child: const Text(
                'Continue as a guest',
                style: TextStyle(
                  color: Color.fromRGBO(53, 194, 193, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
