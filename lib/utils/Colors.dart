import 'dart:ui';

import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

//Main Color Scheme
const colorWhite = Color(0xffffffff);
const colorPrimary = Color(0xFFfb7c3c);
const colorPrimaryDark = Color(0xFF0A100D);
const colorPrimaryDark1 = Color(0xFF1C1C1C);

const colorAccent = Color(0xFF949494);
const colorMilkWhite = Color(0xFFD6D5C9);
const colorPrimaryLight = Color(0xFFb84841);

const colorPinkVariant = Color(0xFF6E6262);
const colorSecondary = Color(0xFF707070);
const textColorPrimary = Color(0xFF2B2B2B);
const textColor = Color(0xFF707070);


const colorGrey = Color(0xFFA8A8A8);


 Color getColorFromHex(String hexColor) {

   if(hexColor.isEmpty || hexColor.length <= 6){
     hexColor = "#000000";
   }

    hexColor = hexColor.toUpperCase().replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    try{
      return Color(int.parse(hexColor, radix: 16));
    }catch (e) {
      return colorPrimaryDark;
    }

}