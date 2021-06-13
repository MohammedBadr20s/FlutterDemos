



import 'package:flutter/material.dart';

Color hexColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}



Locale getCurrentLocale(BuildContext context) {
  return Localizations.localeOf(context);
}