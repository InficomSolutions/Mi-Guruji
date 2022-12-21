import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/back_button.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
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
                      'Hello! Register to get started',
                      style: bold(15),
                    ),
                    const Spacer(),
                    Text(
                      'We will send you confirmation code',
                      style: TextStyle(
                        fontSize: 15,
                        color: '#8391A1'.toColor(),
                      ),
                    ),
                    const Spacer(),
                    CustomTextField(
                      controller: userName,
                      labelText: 'Username',
                    ),
                    h(15),
                    CustomTextField(
                      controller: contact,
                      labelText: 'Contact number',
                      keyboardType: TextInputType.number,
                    ),
                    h(15),
                    CustomTextField(
                      obscureText: hidePassword,
                      controller: password,
                      labelText: 'Password',
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
                    CustomTextField(
                      obscureText: hidePassword,
                      controller: cPassword,
                      labelText: 'Confirm password',
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
                    h(20),
                    CustomButton(
                      fullWidth: true,
                      onPressed: () {},
                      text: 'Register',
                      bgColor: Colors.black,
                      fgColor: Colors.white,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        w(3),
                        InkWell(
                          onTap: () {
                            replaceScreen(context, const LoginPage());
                          },
                          child: Text(
                            'Login Now',
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
