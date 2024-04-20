import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/informacion_usuario.dart';

class PaletteBuilder extends StatefulWidget{
  final Widget Function(BuildContext context) builder;
  final ImageProvider imagen;

  const PaletteBuilder({
    super.key,
    required this.builder,
    required this.imagen,
  });

  @override
  StatePaletteBuilder createState() => StatePaletteBuilder();
}

class StatePaletteBuilder extends State<PaletteBuilder> {
  //ColorScheme? _temaUsuarioLight;
  //ColorScheme? _temaUsuarioDark;

  @override
  void initState() {
    super.initState();
    inicializarTemaUsuario();
  }

  /// Esta funcion se encarga de generar el esquema de color acorde a la imagen
  Future<void> inicializarTemaUsuario() async {
    try {
      await generarColores().then((List<ColorScheme> list) {
        context.read<InformacionUsuario>().establecerEsquemaColor(list[0], list[1]);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Esta funcion usa una herramienta proveida por material para extraer un
  /// esquema de color de una imagen
  Future<List<ColorScheme>> generarColores() async {
    ColorScheme paletaUsuarioLight = await ColorScheme.fromImageProvider(provider: widget.imagen, brightness: Brightness.light);
    ColorScheme paletaUsuarioDark = await ColorScheme.fromImageProvider(provider: widget.imagen, brightness: Brightness.dark);
    return [paletaUsuarioLight, paletaUsuarioDark];
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}