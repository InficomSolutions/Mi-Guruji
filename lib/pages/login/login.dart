import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/forgot_password/forgot_password.dart';
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/pages/register/register.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/back_button.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:techno_teacher/widgets/text_field.dart';

import '../../getx_controller/student_info_controller/student_contorller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final StudentController _controller = Get.put(StudentController());
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset(Images.login).image, fit: BoxFit.fill)),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    // Text(
                    //   'Welcome back! Glad to see you, Again!',
                    //   style: bold(15),
                    // ),
                    const Spacer(),
                    CustomTextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.length != 10) {
                          return "कृपया आपला मोबाईल नंबर तपासा";
                        }
                      },
                      controller: userName,
                      labelText: 'मोबाईल नंबर',
                    ),
                    h(15),
                    CustomTextField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "पासवर्ड टाका";
                        }
                      },
                      obscureText: hidePassword,
                      controller: password,
                      labelText: 'आपला पासवर्ड टाका',
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
                          'पासवर्ड चुकला आहे?',
                          style: TextStyle(
                            color: '#6A707C'.toColor(),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    h(20),
                    loading == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            fullWidth: true,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                _controller
                                    .login(userName.text, password.text)
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              } else {}
                            },
                            text: 'लॉगिन करा',
                            bgColor: Colors.black,
                            fgColor: Colors.white,
                          ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('आपले खाते आहे का?'),
                        w(3),
                        InkWell(
                          onTap: () {
                            replaceScreen(context, RegisterPage());
                          },
                          child: Text(
                            'खाते तयार करा.',
                            style: bold(15, blackcolor),
                          ),
                        ),
                      ],
                    ),
                    h(100)
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
