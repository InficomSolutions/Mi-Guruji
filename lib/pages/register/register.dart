import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();

  SignUpController _schoolController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset(Images.signup).image, fit: BoxFit.fill)),
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
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black87)
                    ),
                    h(18),
                    Text(
                      'We will send you confirmation code',
                      style: TextStyle(
                        fontSize: 15,
                        color: '#8391A1'.toColor(),
                      ),
                    ),
                    h(68),
                    CustomTextField(
                      controller: _schoolController.userName.value,
                      labelText: 'Username',
                    ),
                    h(15),
                    CustomTextField(
                      controller: _schoolController.contact.value,
                      labelText: 'Contact number',
                      keyboardType: TextInputType.number,
                    ),
                    h(15),
                    CustomTextField(
                      obscureText: _schoolController.hidePassword.value,
                      controller: _schoolController.password.value,
                      labelText: 'Password',
                      suffix: IconButton(
                        onPressed: _schoolController.togglePassword(),
                        icon: Icon(
                          _schoolController.hidePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    h(15),
                    CustomTextField(
                      obscureText: _schoolController.hidePassword.value,
                      controller: _schoolController.cPassword.value,
                      labelText: 'Confirm password',
                      suffix: IconButton(
                        onPressed: _schoolController.togglePassword(),
                        icon: Icon(
                          _schoolController.hidePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    h(15),
                    h(20),

                    InkWell(onTap: (){
                      _schoolController.signUpValidation();
                      debugPrint("===============890");
                    },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black87),
                        child: const Center(
                            child: Text(
                          "Register",
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
