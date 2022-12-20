import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.passwordChanged),
              h(15),
              Text(
                'Password Changed!',
                style: bold(14),
              ),
              h(20),
              Text(
                'Your password has been changed\nsuccessfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: '#8391A1'.toColor(),
                ),
              ),
              h(30),
              CustomButton(
                onPressed: () {
                  removeScreens(context, const LoginPage());
                },
                text: 'Back to Login',
                fullWidth: true,
                bgColor: Colors.black,
                fgColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
