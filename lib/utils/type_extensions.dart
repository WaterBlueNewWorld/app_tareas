import 'package:flutter/material.dart';

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