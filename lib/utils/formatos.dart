import 'package:flutter/services.dart';

class Formatos {
  Formatos._();

  /// Filtros para solo permitir decimales y numeros respectivamente usando un
  /// patron de busqueda de caracteres en RegExp
  static FilteringTextInputFormatter decimales() {
    return FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]?[0-9]*', unicode: true));
  }

  static FilteringTextInputFormatter numeros() {
    return FilteringTextInputFormatter.allow(RegExp(r'[0-9]?[0-9]*', unicode: true));
  }

}