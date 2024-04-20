import 'package:flutter/material.dart';
import 'package:lista_tareas/providers/informacion_usuario.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:lista_tareas/routes/home.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String dbs = await getDatabasesPath();
  String dbtareas = join(dbs, 'tareas.db');
  print(dbtareas);
  runApp(MyApp(tareasdb: dbtareas,));
}

class MyApp extends StatelessWidget {
  final String tareasdb;
  const MyApp({super.key, required this.tareasdb});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TareasProvider()),
        ChangeNotifierProvider(create: (_) => InformacionUsuario()),
      ],
      builder: (ctx, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: PaginaPrincipal(dbtareas: tareasdb,),
        );
      },
    );
  }
}
