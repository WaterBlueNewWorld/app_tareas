import 'package:flutter/material.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:provider/provider.dart';

import '../models/tarea_model.dart';
import '../providers/informacion_usuario.dart';

class DialogoConfirmacion extends StatefulWidget {
  final Tarea tarea;

  const DialogoConfirmacion({super.key, required this.tarea});

  @override
  State<DialogoConfirmacion> createState() => _DialogoConfirmacionState();
}

class _DialogoConfirmacionState extends State<DialogoConfirmacion> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("¿Borrar tarea?"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Row(
              children: [
                Text("Desea borrar?")
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Tarea comp = widget.tarea;
                          context.read<TareasProvider>().eliminarTarea(
                            comp,
                            context.read<InformacionUsuario>().db,
                          );
                        },
                        child: const Text("Borrar"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
