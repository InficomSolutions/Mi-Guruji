import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techno_teacher/pages/new_password/new_password.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/widgets/button.dart';

import '../../utils/navigation.dart';
import '../../utils/text_styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/sizedbox.dart';
import '../login/login.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController contact = TextEditingController();
  List<TextEditingController> codes =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focus = List.generate(6, (index) => FocusNode());
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
                      'OTP Verification',
                      style: bold(15),
                    ),
                    h(28),
                    Text(
                      'Enter the verification code we just sent on your contact number',
                      style: TextStyle(
                        fontSize: 15,
                        color: '#8391A1'.toColor(),
                      ),
                    ),
                    h(40),
                    Row(
                      children: codes.map((controller) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextField(
                              cursorColor: Colors.black,
                              focusNode: focus[codes.indexOf(controller)],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: controller,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              onChanged: (v) {
                                if (v.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    h(30),
                    CustomButton(
                      onPressed: () {
                        toScreen(context, const NewPassword());
                      },
                      text: 'Verify',
                      fgColor: Colors.white,
                      bgColor: Colors.black,
                      fullWidth: true,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Didn\'t receive code?'),
                        w(3),
                        InkWell(
                          onTap: () {
                            replaceScreen(context, const LoginPage());
                          },
                          child: Text(
                            'Resend',
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
