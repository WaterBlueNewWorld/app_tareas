import 'package:flutter/material.dart';

import '../models/tarea_model.dart';

class TareasProvider extends ChangeNotifier {
  List<Tarea> listaTareasPendientes = [Tarea(id: 1, titulo: "AAAA", prioridad: Colors.blue, completado: false)];
  List<Tarea> listaTareasCompletadas = [];

  void agregarTarea(Tarea t) {
    listaTareasPendientes.add(t);
    notifyListeners();
  }

  void completarTarea(Tarea t) {
    listaTareasPendientes.removeWhere((element) => element.id == t.id);
    listaTareasCompletadas.add(t);
  }

  void descompletarTarea(Tarea t) {
    listaTareasCompletadas.removeWhere((element) => element.id == t.id);
    listaTareasPendientes.add(t);
  }
}