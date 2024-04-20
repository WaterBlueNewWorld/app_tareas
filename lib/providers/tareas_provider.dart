import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarea_model.dart';

class TareasProvider extends ChangeNotifier {
  List<Tarea> listaTareasPendientes = [];
  List<Tarea> listaTareasCompletadas = [];

  Future<void> agregarTarea(Tarea t, String conexion) async {
    final dbTareas = await openDatabase(conexion);
    Tarea nuevatarea = Tarea(id: null, prioridad: t.prioridad, titulo: t.titulo, completado: t.completado,);
    int id = await dbTareas.insert('tareas', nuevatarea.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    nuevatarea.id = id;

    listaTareasPendientes.add(nuevatarea);
    notifyListeners();
  }

  Future<void> completarTarea(Tarea t, String conexion) async {
    final dbTareas = await openDatabase(conexion);

    await dbTareas.update(
      'tareas',
      t.toJson(),
      where: "id = ?",
      whereArgs: [t.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    ).whenComplete(() {
      listaTareasPendientes.removeWhere((element) => element.id == t.id);
      listaTareasCompletadas.add(t);
      dbTareas.close();
    }).onError((error, stackTrace) {
      dbTareas.close();
      throw Exception(stackTrace.toString());
    });
    notifyListeners();
  }

  Future<void> descompletarTarea(Tarea t, String conexion) async {
    final dbTareas = await openDatabase(conexion);

    await dbTareas.update(
      'tareas',
      t.toJson(),
      where: "id = ?",
      whereArgs: [t.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    ).whenComplete(() {
      listaTareasCompletadas.removeWhere((element) => element.id == t.id);
      listaTareasPendientes.add(t);
      dbTareas.close();
    }).onError((error, stackTrace) {
      dbTareas.close();
      throw Exception(stackTrace.toString());
    });
    notifyListeners();
  }

  void inicializarDatosDb(List<Map<String, dynamic>> pendientes, List<Map<String, dynamic>> completados,) {
    listaTareasPendientes = pendientes.map((e) => Tarea.fromJson(e)).toList();
    listaTareasCompletadas = completados.map((e) => Tarea.fromJson(e)).toList();
    notifyListeners();
  }

  void eliminarTarea(Tarea t, String conexion) async {
    final dbTareas = await openDatabase(conexion);

    await dbTareas.delete(
      'tareas',
      where: "id = ?",
      whereArgs: [t.id]
    ).whenComplete(() {
      listaTareasPendientes.removeWhere((element) => element.id == t.id);
      listaTareasCompletadas.removeWhere((element) => element.id == t.id);
      dbTareas.close();
    }).onError((error, stackTrace) {
      dbTareas.close();
      throw Exception(stackTrace.toString());
    });
    notifyListeners();
  }
}