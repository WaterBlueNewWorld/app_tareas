import 'package:flutter/material.dart';

class Prioridades {
  final Color color;
  final String prioridad;

  const Prioridades({
    required this.color,
    required this.prioridad
  });

  bool isEqual(Prioridades p) => p.prioridad == prioridad;

  static const List<Prioridades> prioridades = [
    Prioridades(color: Colors.red, prioridad: "Alta",),
    Prioridades(color: Colors.yellow, prioridad: "Media",),
    Prioridades(color: Colors.blue, prioridad: "Baja",),
  ];
}