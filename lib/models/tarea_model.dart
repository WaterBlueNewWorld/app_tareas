import 'package:flutter/material.dart';
import 'package:lista_tareas/utils/type_extensions.dart';

class Tarea {
  int? id;
  String titulo;
  bool completado;
  Color prioridad;

  Tarea({
    this.id,
    required this.titulo,
    required this.completado,
    required this.prioridad,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
    id: json['id'],
    titulo: json['nombre'],
    completado: (json['completado'] as int).toBool(),
    prioridad: json['prioridad'].toString().toColor(),
  );

  Map<String, dynamic> toJson() => {
    "nombre" : titulo,
    "completado" : completado.toInt(),
    "prioridad" : prioridad.toHex(),
  };
}