import 'package:flutter/material.dart';
import 'package:lista_tareas/models/prioridades_model.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:lista_tareas/widgets/dialogo_tarea.dart';
import 'package:provider/provider.dart';

import '../models/tarea_model.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final ScrollController _controlTareas = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (ctx) {
            return DialogoTarea(
              titulo: "",
              prioridad: Colors.blue,
              callback: (Tarea t) {
                context.read<TareasProvider>().agregarTarea(t);
              },
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: 300,
              child: ListView(
                controller: _controlTareas,
                children: [
                  Column(
                    children: List.generate(
                      context.read<TareasProvider>().listaTareasPendientes.length,
                      (index) {
                        List<Tarea> tareasPendientes = context.read<TareasProvider>().listaTareasPendientes;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Card(
                            child: Center(
                              child: ListTile(
                                leading: Container(width: 15, height: 15, decoration: BoxDecoration(color: tareasPendientes[index].prioridad),),
                                title: Text(tareasPendientes[index].titulo),
                                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.check),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),],
      ),
    );
  }
}
