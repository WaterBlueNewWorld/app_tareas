import 'package:flutter/material.dart';

extension ToBool on int {
  bool toBool() => this == 1 ? true : false;
}

extension ToInt on bool {
  int toInt() => this == true ? 1 : 0;
}

extension HaciaHexColor on Color {
  String toHex({bool conSimbolo = false}) {
    if (conSimbolo) {
      return "#"
          "${alpha.toRadixString(16).padLeft(2, '0')}"
          "${red.toRadixString(16).padLeft(2, '0')}"
          "${green.toRadixString(16).padLeft(2, '0')}"
          "${blue.toRadixString(16).padLeft(2, '0')}".replaceAll("ff", "");
    } else {
      return "${alpha.toRadixString(16).padLeft(2, '0')}"
          "${red.toRadixString(16).padLeft(2, '0')}"
          "${green.toRadixString(16).padLeft(2, '0')}"
          "${blue.toRadixString(16).padLeft(2, '0')}".replaceAll("ff", "");
    }
  }
}

extension HaciaHex on MaterialColor {
  String toHex({bool conSimbolo = false}) {
    if (conSimbolo) {
      return "#"
          "${alpha.toRadixString(16).padLeft(2, '0')}"
          "${red.toRadixString(16).padLeft(2, '0')}"
          "${green.toRadixString(16).padLeft(2, '0')}"
          "${blue.toRadixString(16).padLeft(2, '0')}".replaceAll("ff", "");
    } else {
      return "${alpha.toRadixString(16).padLeft(2, '0')}"
          "${red.toRadixString(16).padLeft(2, '0')}"
          "${green.toRadixString(16).padLeft(2, '0')}"
          "${blue.toRadixString(16).padLeft(2, '0')}".replaceAll("ff", "");
    }
  }
}

extension DesdeHex on String {
  Color toColor() {
    String hexColor = replaceAll("#", "replace");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}