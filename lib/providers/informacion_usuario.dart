import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformacionUsuario extends ChangeNotifier {
  String _nombre = "Usuario";
  ThemeMode? _temaApp;
  ColorScheme _temaClaroDefault = const ColorScheme.light();
  ColorScheme _temaObscuroDefault = const ColorScheme.light();

  String get nombre => _nombre;
  ThemeMode get temaActual => _temaApp ?? ThemeMode.light;
  ColorScheme get temaClaroDefault => _temaClaroDefault;
  ColorScheme get temaObscuroDefault => _temaObscuroDefault;

  void inicializarDatosUsuario({
    required String nombre,
  }) {
    _nombre = nombre;
    notifyListeners();
  }

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
    _nombre = "";
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