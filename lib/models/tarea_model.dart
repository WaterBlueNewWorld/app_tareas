import 'package:flutter/material.dart';

class Tarea {
  int id;
  String titulo;
  bool completado;
  Color prioridad;

  Tarea({
    required this.id,
    required this.titulo,
    required this.completado,
    required this.prioridad,
  });

  Map<String, dynamic> toJson() => {
    "id" : id,
    "Titulo" : titulo,
    "Completado" : completado,
    "Prioridad" : prioridad,
  };
}