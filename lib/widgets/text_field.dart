import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techno_teacher/utils/extension.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Color? bgColor;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.bgColor,
    this.suffix,
    this.prefix,
    this.validator,
    this.labelText,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2.5,
      child: TextFormField(
        validator: validator,
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        decoration: InputDecoration(
          filled: true,
          fillColor: '#F7F8F9'.toColor(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelText: labelText,
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelStyle: TextStyle(
            fontSize: 15,
            color: '#8391A1'.toColor(),
          ),
          contentPadding:
              const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        ),
      ),
    );
  }
}
