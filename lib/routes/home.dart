import 'package:flutter/material.dart';
import 'package:lista_tareas/providers/informacion_usuario.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:lista_tareas/routes/calc_propina/calc_propina.dart';
import 'package:lista_tareas/routes/info_api/datos_api.dart';
import 'package:lista_tareas/routes/tareas_pendientes/tareas_pendientes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class PaginaPrincipal extends StatefulWidget {
  final String dbtareas;
  const PaginaPrincipal({super.key, required this.dbtareas});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final List<Widget> _pantallas = [
    const TareasPendientes(),
    const CalculadoraPropina(),
    const ProductosApi(),
  ];
  int _indiceStack = 0;

  @override
  void initState() {
    super.initState();
    inicializacion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indiceStack,
        alignment: Alignment.center,
        children: _pantallas,
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 8,
        //type: BottomNavigationBarType.shifting,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.task), label: "Tareas pendientes"),
          NavigationDestination(icon: Icon(Icons.calculate), label: "Calculadora"),
          NavigationDestination(icon: Icon(Icons.api), label: "Rest API"),
        ],
        selectedIndex: _indiceStack,
        indicatorColor: Colors.white,
        onDestinationSelected: (int i) {
          setState(() {
            _indiceStack = i;
          });
        },
      ),
    );
  }

  void inicializacion() async {
    context.read<InformacionUsuario>().db = widget.dbtareas;
    final db = await openDatabase(widget.dbtareas);
    List<Map<String, dynamic>> pendientes;
    List<Map<String, dynamic>> completados;
    var res = await db.rawQuery("SELECT true WHERE EXISTS(SELECT name from sqlite_master WHERE type='table' AND name='tareas');");
    if (res.isEmpty || !(res.first['true'] == 1)) {
      db.execute(
       "CREATE TABLE tareas(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, prioridad TEXT, completado BIT);",
      );
    } else {
      pendientes = await db.query('tareas', where: 'completado=?', whereArgs: ['0']);
      completados = await db.query('tareas', where: 'completado=?', whereArgs: ['1']);
      if(mounted) {
        context.read<TareasProvider>().inicializarDatosDb(pendientes, completados);
      }
    }
  }
}
