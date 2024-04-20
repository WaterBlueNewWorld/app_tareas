import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_tareas/widgets/indicador.dart';
import 'package:provider/provider.dart';

import '../../models/tarea_model.dart';
import '../../providers/informacion_usuario.dart';
import '../../providers/tareas_provider.dart';
import '../../widgets/dialogo_tarea.dart';

class TareasPendientes extends StatefulWidget {
  const TareasPendientes({super.key});

  @override
  State<TareasPendientes> createState() => _TareasPendientesState();
}

class _TareasPendientesState extends State<TareasPendientes> with TickerProviderStateMixin {
  final ScrollController _controlTareasPendientes = ScrollController();
  final ScrollController _controlTareasCompletadas = ScrollController();
  late final TabController _tabController;
  int _indiceListaTareas = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _indiceListaTareas,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          controller: _controlTareasPendientes,
                          children: [
                            Consumer<TareasProvider>(
                              builder: (ctx, provider, e) {
                                return Column(
                                  children: List.generate(
                                    provider.listaTareasPendientes.length, (index) {
                                      return Dismissible(
                                        background: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: const Icon(Icons.delete_forever),
                                        ),
                                        onDismissed: (direction) {
                                          Tarea comp = provider.listaTareasPendientes[index];
                                          provider.eliminarTarea(
                                            comp,
                                            context.read<InformacionUsuario>().db,
                                          );
                                        },
                                        key: Key(provider.listaTareasPendientes[index].id.toString()),
                                        child: Card(
                                          child: ListTile(
                                            leading: Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: provider.listaTareasPendientes[index].prioridad,
                                              ),
                                            ),
                                            title: Text(provider.listaTareasPendientes[index].titulo),
                                            trailing: SizedBox(
                                              width: MediaQuery.of(context).size.width / 4,
                                              child: Row( mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Expanded(flex: 5, child: IconButton(onPressed: () async {
                                                    Tarea comp = provider.listaTareasPendientes[index]..completado = true;
                                                    provider.completarTarea(
                                                      comp,
                                                      context.read<InformacionUsuario>().db,
                                                    );
                                                  }, icon: const Icon(Icons.check),)),
                                                  const SizedBox(width: 25,),
                                                  Expanded(flex: 5, child: IconButton(onPressed: () {
                                                    Tarea comp = provider.listaTareasPendientes[index];
                                                    provider.eliminarTarea(
                                                      comp,
                                                      context.read<InformacionUsuario>().db,
                                                    );
                                                  }, icon: const Icon(Icons.close),))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          controller: _controlTareasCompletadas,
                          children: [
                            Consumer<TareasProvider>(
                              builder: (ctx, provider, e) {
                                return Column(
                                  children: List.generate(
                                    context.read<TareasProvider>().listaTareasCompletadas.length,
                                        (index) {
                                      return Card(
                                        child: Center(
                                          child: ListTile(
                                            leading: Container(width: 15, height: 15, decoration: BoxDecoration(color: provider.listaTareasCompletadas[index].prioridad),),
                                            title: Text(provider.listaTareasCompletadas[index].titulo),
                                            trailing: SizedBox(
                                              width: MediaQuery.of(context).size.width / 4,
                                              child: Row( mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Expanded(flex: 5, child: IconButton(onPressed: () {
                                                    Tarea comp = provider.listaTareasCompletadas[index]..completado = false;
                                                    provider.descompletarTarea(
                                                      comp,
                                                      context.read<InformacionUsuario>().db,
                                                    );
                                                  }, icon: const Icon(Icons.refresh),)),
                                                  const SizedBox(width: 25,),
                                                  Expanded(flex: 5, child: IconButton(onPressed: () {
                                                    Tarea comp = provider.listaTareasCompletadas[index];
                                                    provider.eliminarTarea(
                                                      comp,
                                                      context.read<InformacionUsuario>().db,
                                                    );
                                                  }, icon: const Icon(Icons.close),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 35,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Divider(color: Colors.grey, height: 1,),
            ),
          ),
          Positioned(
            bottom: -5,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                indicator: Indicador(context: context),
                indicatorPadding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                splashFactory: NoSplash.splashFactory,
                mouseCursor: SystemMouseCursors.click,
                onTap: (v) {
                  setState(() {
                    _indiceListaTareas = v;
                  });
                },
                tabs: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.toc_outlined,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Por hacer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.toc_outlined,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Completadas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 52,
            child: FloatingActionButton(
              elevation: 2,
              onPressed: () {
                showDialog(context: context, builder: (ctx) {
                  return DialogoTarea(
                    titulo: "",
                    prioridad: Colors.blue,
                    callback: (Tarea t) {
                    },
                  );
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
