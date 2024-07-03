// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/theme_controller.dart';

class HelperFunctions {
  static ThemeData getCurrentThemeData(BuildContext context) {
    return Provider.of<ThemeController>(context).themeData;
  }
}
