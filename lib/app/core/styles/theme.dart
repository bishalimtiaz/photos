import 'package:flutter/material.dart';
import 'package:photos/app/core/styles/colors.dart';
import 'package:photos/app/core/styles/text_styles.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    background: backgroundColor,
  ),
  textTheme: TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  ),
);
