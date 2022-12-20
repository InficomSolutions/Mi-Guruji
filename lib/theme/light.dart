import 'package:flutter/material.dart';

Color primaryColor = Colors.black;

Map<int, Color> colors = {
  for (var item in List.generate(10, (index) {
    return index == 0 ? 50 : index * 100;
  }))
    item: primaryColor.withOpacity(item == 50 ? 0.1 : item / 1000 + 0.1)
};
MaterialColor primarySwatch = MaterialColor(0xFFFFFFFF, colors);

ThemeData light = ThemeData(
  primarySwatch: primarySwatch,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
);
