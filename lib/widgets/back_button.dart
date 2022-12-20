import 'package:flutter/material.dart';
import 'package:techno_teacher/utils/navigation.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        pop(context);
      },
      icon: Container(
        alignment: Alignment.center,
        height: 41,
        width: 41,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(232, 236, 244, 1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 20,
        ),
      ),
    );
  }
}
