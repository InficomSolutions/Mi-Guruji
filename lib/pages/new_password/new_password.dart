import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/pages/new_password/password_changed.dart';
import 'package:techno_teacher/pages/welcome/welcome.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:http/http.dart' as http;

import '../../utils/text_styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/sizedbox.dart';
import '../../widgets/text_field.dart';

class NewPassword extends StatefulWidget {
  var mobilenum;
  NewPassword({Key? key, this.mobilenum}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController cNewPassword = TextEditingController();
  bool hidePassword = true;
  GlobalKey<FormState> formKey = GlobalKey();
  bool progress = false;

  togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  setnewpassword() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      setState(() {
        progress = true;
      });
      var response =
          await http.post(Uri.parse(TGuruJiUrl.foregotpassword), headers: {
        'token': "$token",
      }, body: {
        "mobileno": widget.mobilenum,
        "newpassword": cNewPassword.text
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        toScreen(context, const PasswordChanged());
        setState(() {
          progress = false;
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
        toScreen(context, WelcomePage());
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
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
                      'Create new password',
                      style: bold(15),
                    ),
                    h(28),
                    Text(
                      'Your new password must be unique from those previously used',
                      style: TextStyle(
                        fontSize: 15,
                        color: '#8391A1'.toColor(),
                      ),
                    ),
                    h(40),
                    CustomTextField(
                      obscureText: hidePassword,
                      controller: newPassword,
                      labelText: 'New Password',
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
                      validator: (p0) {
                        if (p0 != newPassword.text) {
                          return "Password does not match";
                        }
                      },
                      obscureText: hidePassword,
                      controller: cNewPassword,
                      labelText: 'Confirm Password',
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
                    h(30),
                    progress == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setnewpassword();
                              } else {}
                            },
                            text: 'Reset Password',
                            fgColor: Colors.white,
                            bgColor: Colors.black,
                            fullWidth: true,
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
