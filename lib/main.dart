import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lista_tareas/providers/informacion_usuario.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:lista_tareas/routes/home.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Obtengo la informacion de la ruta de la base de datos para pasarla
  /// a la app principal
  String dbs = await getDatabasesPath();
  String dbtareas = join(dbs, 'tareas.db');
  /// Mantengo el splash hasta que se cargue la info necesaria
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(tareasdb: dbtareas,));
}

class MyApp extends StatelessWidget {
  final String tareasdb;
  const MyApp({super.key, required this.tareasdb});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Providers necesarios para las pantallas
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TareasProvider()),
        ChangeNotifierProvider(create: (_) => InformacionUsuario()),
      ],
      builder: (ctx, child) {
        return ChangeNotifierProvider(
          create: (_) => InformacionUsuario(),
          child: Consumer<InformacionUsuario>(
            builder: (ctx, provider, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: provider.temaClaroDefault,
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: provider.temaObscuroDefault,
                  useMaterial3: true,
                ),
                themeMode: ctx.read<InformacionUsuario>().temaActual,
                home: PaginaPrincipal(dbtareas: tareasdb,),
              );
            },
          ),
        );
      },
    );
  }
}
