import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/back_button.dart';
import 'package:techno_teacher/widgets/button.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:techno_teacher/widgets/text_field.dart';
import '../../getx_controller/auth/sign_up_controller.dart';
import '../../utils/images.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool hidePassword = true;
  bool hidecfPassword = true;

  togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  togglecfPassword() {
    setState(() {
      hidecfPassword = !hidecfPassword;
    });
  }

  SignUpController _schoolController = Get.put(SignUpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvalue();
  }

  getvalue() async {
    var reffer = await Authcontroller().getreffer();
    setState(() {
      _schoolController.referal.value.text = reffer ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: const CustomBackButton()),
                h(18),
                Text('आपले खाते तयार करा.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                h(18),
                // Text(
                //   'We will send you confirmation code',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: '#8391A1'.toColor(),
                //   ),
                // ),
                // h(18),
                CustomTextField(
                  onchange: (value) {
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "कृपया आपले नाव भरावे.";
                    }
                  },
                  controller: _schoolController.userName.value,
                  labelText: 'पहिले नाव',
                ),
                h(15),
                CustomTextField(
                  onchange: (value) {
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "कृपया आडनाव भरावे.";
                    }
                  },
                  controller: _schoolController.lastuserName.value,
                  labelText: 'आडनाव',
                ),
                // h(15),
                // CustomTextField(
                //   onchange: (Value) {
                //     formKey.currentState!.validate();
                //   },
                //   validator: (p0) {
                //     String pattern =
                //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                //     RegExp regex = RegExp(pattern);
                //     if (!regex.hasMatch(p0!)) {
                //       return 'Enter Valid Email';
                //     } else {
                //       return null;
                //     }
                //   },
                //   controller: _schoolController.email.value,
                //   labelText: 'Email',
                // ),
                h(15),
                CustomTextField(
                  onchange: (value) {
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0!.length != 10) {
                      return "मोबाईल नंबर चुकीचा आहे.";
                    }
                  },
                  controller: _schoolController.contact.value,
                  labelText: 'मोबाईल नंबर',
                  keyboardType: TextInputType.number,
                ),
                h(15),
                CustomTextField(
                  controller: _schoolController.referal.value,
                  labelText: 'रेफर कोड',
                ),
                h(15),
                CustomTextField(
                  obscureText: hidePassword,
                  controller: _schoolController.password.value,
                  labelText: 'पासवर्ड',
                  suffix: IconButton(
                    onPressed: () {
                      togglePassword();
                    },
                    icon: Icon(
                      !hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                h(15),
                CustomTextField(
                  onchange: (Value) {
                    formKey.currentState!.validate();
                  },
                  validator: (p0) {
                    if (p0 != _schoolController.password.value.text) {
                      return "पासवर्ड जुळत नाही";
                    }
                  },
                  obscureText: hidecfPassword,
                  controller: _schoolController.cPassword.value,
                  labelText: 'पासवर्ड तपासा',
                  suffix: IconButton(
                    onPressed: () {
                      togglecfPassword();
                    },
                    icon: Icon(
                      !hidecfPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                h(15),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _schoolController.signUpValidation();
                    } else {}
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black87),
                    child: const Center(
                        child: Text(
                      "खाते तयार करा",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                    )),
                  ),
                ),
                // CustomButton(
                //   fullWidth: true,
                //   onPressed: () {
                //
                //   },
                //   text: 'Register',
                //   bgColor: Colors.black,
                //   fgColor: Colors.white,
                // ),
                // const Spacer(),
                h(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('आपले खाते आहे का?'),
                    w(3),
                    InkWell(
                      onTap: () {
                        replaceScreen(context, const LoginPage());
                      },
                      child: Text(
                        'लॉगीन करा',
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
    );
  }
}
