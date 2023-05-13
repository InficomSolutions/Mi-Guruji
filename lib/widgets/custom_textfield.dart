import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.hintText,
    required this.lableText,
    required this.inputType,
    required this.textCapitalization,
    required this.inputAction,
    required this.controller,
    this.enable,
    this.bgtrue,
    this.validate,
  }) : super(key: key);
  String lableText, hintText;
  TextInputType inputType;
  TextCapitalization textCapitalization;
  TextInputAction inputAction;
  TextEditingController controller;
  bool? enable;
  bool? bgtrue;
  var validate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: bgtrue == true ? Colors.grey.shade300 : null,
      margin: EdgeInsets.all(15),
      child: TextFormField(
        validator: validate,
        controller: controller,
        enabled: enable,
        textInputAction: inputAction,
        textCapitalization: textCapitalization,
        keyboardType: inputType,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        onChanged: (value) {},
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          // prefixIcon: Icon(
          //   Icons.person_outline_rounded,
          //   color: Colors.grey,
          // ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          fillColor: Colors.grey,

          hintText: hintText,

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: lableText,

          //lable style
          labelStyle: TextStyle(
            color: blackcolor,
            fontSize: 18,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
