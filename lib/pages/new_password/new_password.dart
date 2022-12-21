import 'package:flutter/material.dart';
import 'package:techno_teacher/pages/new_password/password_changed.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/widgets/button.dart';

import '../../utils/text_styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/sizedbox.dart';
import '../../widgets/text_field.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController cNewPassword = TextEditingController();
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
                    CustomButton(
                      onPressed: () {
                        toScreen(context, const PasswordChanged());
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
