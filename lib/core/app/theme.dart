import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/core/app/palette.dart';

final ThemeData basicTheme = buildBasicTheme();

ThemeData buildBasicTheme() {
  Color primaryColor = Palette.blue;
  Color secondaryColor = Palette.darkBlue;

  final ColorScheme colorScheme = const ColorScheme.light()
      .copyWith(primary: primaryColor, secondary: secondaryColor);

  final ThemeData base = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    primaryColor: primaryColor,
    primaryColorLight: primaryColor,
    indicatorColor: Palette.white,
    hintColor: secondaryColor,
    hoverColor: Palette.red,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: secondaryColor),
    buttonTheme: ButtonThemeData(
        colorScheme: colorScheme, textTheme: ButtonTextTheme.primary),
    //textButtonTheme: baseCustomButton());
  );
  return base.copyWith();
}

buildInputDecorationTheme(InputDecorationTheme base) {
  return base.copyWith(
    border: UnderlineInputBorder(borderSide: BorderSide(color: Palette.blue)),
  );
}

TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    titleSmall: base.titleSmall?.copyWith(
      fontFamily: "Nunito",
      color: Palette.white,
      fontSize: 12,
    ),
  );
}
