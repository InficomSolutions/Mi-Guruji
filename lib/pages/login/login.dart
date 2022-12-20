import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/forgot_password/forgot_password.dart';
import 'package:techno_teacher/pages/register/register.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/back_button.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePassword = true;

  togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    h(28),
                    Text(
                      'Welcome back! Glad to see you, Again!',
                      style: bold(15),
                    ),
                    const Spacer(),
                    CustomTextField(
                      controller: userName,
                      labelText: 'Username/ Contact number',
                    ),
                    h(15),
                    CustomTextField(
                      controller: password,
                      labelText: 'Enter your password',
                      suffix: IconButton(
                        onPressed: togglePassword,
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    h(15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          toScreen(context, const ForgotPassword());
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: '#6A707C'.toColor(),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    h(20),
                    CustomButton(
                      fullWidth: true,
                      onPressed: () {},
                      text: 'Login',
                      bgColor: Colors.black,
                      fgColor: Colors.white,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        w(3),
                        InkWell(
                          onTap: () {
                            replaceScreen(context, const RegisterPage());
                          },
                          child: Text(
                            'Register Now',
                            style: bold(15, '#35C2C1'.toColor()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
