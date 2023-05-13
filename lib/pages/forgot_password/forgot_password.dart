import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techno_teacher/pages/otp/otp.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/widgets/button.dart';

import '../../utils/navigation.dart';
import '../../utils/text_styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/sizedbox.dart';
import '../../widgets/text_field.dart';
import '../login/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController contact = TextEditingController();
  bool progress = false;

  sendotp() async {
    setState(() {
      progress = true;
    });
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${contact.text}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        Fluttertoast.showToast(msg: '$error');
      },
      codeSent: (verificationId, forceResendingToken) {
        toScreen(
            context,
            OTP(
              verify: verificationId,
              mobilenum: contact.text,
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    h(28),
                    Text(
                      'Forgot Password?',
                      style: bold(15),
                    ),
                    h(28),
                    Text(
                      'Don\'t worry! It occurs. Please enter the contact number linked with your account.',
                      style: TextStyle(
                        fontSize: 15,
                        color: '#8391A1'.toColor(),
                      ),
                    ),
                    h(40),
                    CustomTextField(
                      controller: contact,
                      onchange: (value) {
                        formkey.currentState!.validate();
                      },
                      validator: (p0) {
                        if (p0!.length != 10) {
                          return "मोबाईल नंबर चुकीचा आहे.";
                        }
                      },
                      labelText: 'मोबाईल नंबर',
                      keyboardType: TextInputType.number,
                    ),
                    h(30),
                    progress == true
                        ? CircularProgressIndicator()
                        : CustomButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                sendotp();
                              }
                            },
                            text: 'Send Code',
                            fgColor: Colors.white,
                            bgColor: Colors.black,
                            fullWidth: true,
                          ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Remember Password?'),
                        w(3),
                        InkWell(
                          onTap: () {
                            replaceScreen(context, const LoginPage());
                          },
                          child: Text(
                            'Login',
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
