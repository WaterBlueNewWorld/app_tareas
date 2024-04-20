import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lista_tareas/models/prioridades_model.dart';
import 'package:lista_tareas/providers/informacion_usuario.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarea_model.dart';

typedef CallbackDialogo = Function(Tarea t);

class DialogoTarea extends StatefulWidget {
  final String titulo;
  final Color prioridad;
  final CallbackDialogo callback;

  const DialogoTarea({
    super.key,
    required this.titulo,
    required this.callback,
    this.prioridad = Colors.blue
  });

  @override
  State<DialogoTarea> createState() => _DialogoTareaState();
}

/// Dialogo utilizado para la creacion de tareas en la lista de tareas
/// Este dialogo hace llamadas a la db para escribir los datos si se
/// decide crear una nueva tarea
class _DialogoTareaState extends State<DialogoTarea> {
  final TextEditingController _controlTituloTarea = TextEditingController();
  late final Database dbTareas;
  late Color _prioridad;
  final GlobalKey<FormState> _formDialogo = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _prioridad = widget.prioridad;
    inicializar();
  }

  @override
  void dispose() {
    super.dispose();
    dbTareas.close();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 500,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: _formDialogo,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.edit,
                            ),
                            labelText: "Titulo",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5,
                              ),
                            ),
                            labelStyle: const TextStyle(
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.error,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                          ),
                          controller: _controlTituloTarea,
                          validator: (v) {
                            if (v!.isEmpty || v == " ") {
                              return 'Favor de rellenar este campo';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 70,
                        child: DropdownSearch<Prioridades>(
                          validator: (v) {
                            if (v == null) {
                              return 'Seleccione una prioridad';
                            }
                            return null;
                          },
                          dropdownBuilder: (ctx, color) {
                            return Center(
                              child: ListTile(
                                title: Text(color!.prioridad),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    color: color.color,
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0),),
                                  ),
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            );
                          },
                          dropdownButtonProps: const DropdownButtonProps(
                            tooltip: "Prioridad",
                          ),
                          selectedItem: Prioridades.prioridades.last,
                          compareFn: (i, s) => i.isEqual(s),
                          popupProps: PopupProps.menu(
                            itemBuilder: _popItemBuilderColores,
                            showSelectedItems: true,
                          ),
                          onChanged: (Prioridades? v) {
                            setState(() {
                              _prioridad = v!.color;
                            });
                          },
                          items: Prioridades.prioridades,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Prioridad",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.color_lens_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                        if (_formDialogo.currentState!.validate()) {
                          Tarea tarea = Tarea(id: null, titulo: _controlTituloTarea.text, completado: false, prioridad: _prioridad);
                          context.read<TareasProvider>().agregarTarea(tarea, context.read<InformacionUsuario>().db).whenComplete(() {
                            Navigator.of(context).pop(true);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campos vacios")));
                        }
                      },
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Future<void> inicializar() async {
    String conexion = context.read<InformacionUsuario>().db;
    dbTareas = await openDatabase(conexion);
  }

  Widget _popItemBuilderColores(BuildContext context, Prioridades? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.all( 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Center(
        child: ListTile(
          selected: isSelected,
          title: Text(item!.prioridad),
          trailing: Container(
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: const BorderRadius.all(Radius.circular(5.0),
              ),
            ),
            height: 25,
            width: 25,
          ),
        ),
      ),
    );
  }
}
