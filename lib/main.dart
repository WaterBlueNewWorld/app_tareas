import 'package:flutter/material.dart';
import 'package:lista_tareas/providers/tareas_provider.dart';
import 'package:lista_tareas/routes/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TareasProvider()),
      ],
      builder: (ctx, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PaginaPrincipal(),
        );
      },
    );
  }
}
