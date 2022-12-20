import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool fullWidth;
  final Color? bgColor;
  final Color? fgColor;
  final Color borderColor;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fullWidth = false,
    this.bgColor,
    this.fgColor,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: fullWidth ? double.maxFinite : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: fgColor,
          backgroundColor: bgColor,
        ),
        child: Text(text),
      ),
    );
  }
}
