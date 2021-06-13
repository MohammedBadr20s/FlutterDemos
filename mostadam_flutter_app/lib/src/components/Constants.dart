

import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/components/utils.dart';

class ImagePaths {

  static final ImagePaths shared = ImagePaths();

  String mostadamLogo = "assets/images/colored-logo.png";
  String loginEngineerPic = "assets/images/engineer.png";
}


Color mostadamTintColor() => hexColor("1AB690");
Color mostadamButtonBackgroundColor() => hexColor("023A49");
Color mostadamTextdarkBlueColor() => hexColor("023A49");
Color mostadamViewBackgroundColor() => hexColor("E5F5FA");
const MaterialColor mostadamMaterialColor = const MaterialColor(
  0xFF1AB690,
  const <int, Color>{
    50: const Color(0xFF1AB690),
    100: const Color(0xFF1AB690),
    200: const Color(0xFF1AB690),
    300: const Color(0xFF1AB690),
    400: const Color(0xFF1AB690),
    500: const Color(0xFF1AB690),
    600: const Color(0xFF1AB690),
    700: const Color(0xFF1AB690),
    800: const Color(0xFF1AB690),
    900: const Color(0xFF1AB690),
  },
);