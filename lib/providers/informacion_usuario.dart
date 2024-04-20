import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformacionUsuario extends ChangeNotifier {
  String db = "Usuario";
  ThemeMode? _temaApp;
  ColorScheme _temaClaroDefault = const ColorScheme.light();
  ColorScheme _temaObscuroDefault = const ColorScheme.dark();

  /// Temas de la app inicializados en Palette builder
  ThemeMode get temaActual => _temaApp ?? ThemeMode.light;
  ColorScheme get temaClaroDefault => _temaClaroDefault;
  ColorScheme get temaObscuroDefault => _temaObscuroDefault;

  void cambioTema(ThemeMode tema) async {
    _temaApp = tema;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tema', tema.name);
    notifyListeners();
  }

  void establecerEsquemaColor(ColorScheme claro, ColorScheme obscuro) async {
    _temaClaroDefault = claro;
    _temaObscuroDefault = obscuro;
    notifyListeners();
  }

  void eliminarCache() {
    db = "";
    _temaClaroDefault = const ColorScheme.light();
    _temaObscuroDefault = const ColorScheme.dark();
  }

  Future<void> cargarConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tema = prefs.getString('tema') ?? 'light';
    if (tema == "dark") {
      _temaApp = ThemeMode.dark;
    } else {
      _temaApp = ThemeMode.light;
    }
    notifyListeners();
  }
}