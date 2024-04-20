import 'package:flutter/material.dart';
import 'package:lista_tareas/utils/formatos.dart';

class CalculadoraPropina extends StatefulWidget {
  const CalculadoraPropina({super.key});

  @override
  State<CalculadoraPropina> createState() => _CalculadoraPropinaState();
}

/// Esta clase es la que crea la calculadora de propina
/// usando la calculadora de propina de watchOS cree una calculadora que
/// ademas de proveer la propina da la cantidad de propina por personas que van
/// a pagar
///
/// Fuera de esto lo demas son simples operaciones matematicas
class _CalculadoraPropinaState extends State<CalculadoraPropina> {
  final GlobalKey<FormState> llaveForm = GlobalKey<FormState>();
  final TextEditingController cantidadDineroController = TextEditingController();
  final TextEditingController porcentajeController = TextEditingController();
  final TextEditingController cantidadPersonasController = TextEditingController();
  int cantidadpersonas = 1;
  int porcentaje = 10;
  double cantidadDinero = 0;
  double resultadoPropina = 0;
  double resultadoPagoPorPersona = 0;
  double resultadoPagoTotal = 0;

  @override
  void initState() {
    super.initState();
    porcentajeController.text = "10%";
    cantidadPersonasController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 15, right: 15),
                  child: SizedBox(
                    child: Form(
                      key: llaveForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: cantidadDineroController,
                            inputFormatters: [
                              Formatos.numeros()
                            ],
                            validator: (String? v) {
                              if (v! == "" || v.isEmpty) {
                                return "Ingrese un valor";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (String? n) {
                              setState(() {
                                cantidadDinero = double.parse(n!);
                                cantidadDineroController.text = n;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.numbers,
                              ),
                              labelText: "Cantidad",
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
                          ),
                          const SizedBox(height: 15,),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (porcentaje <= 0.0) {
                                            return;
                                          } else {
                                            porcentaje -= 5;
                                            porcentajeController.text = "${porcentaje.toString()}%";
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    controller: porcentajeController,
                                    inputFormatters: [
                                      Formatos.decimales(),
                                    ],
                                    textAlign: TextAlign.center,
                                    showCursor: true,
                                    onEditingComplete: () {  },
                                    onChanged: (String text) {
                                      if (text.trim() == ""){
                                        porcentaje = int.parse("1");
                                      } else {
                                        porcentaje = int.parse(text);
                                      }
                                    },
                                    onSubmitted: (String text) {
                                      if (text.trim() == ""){
                                        porcentaje = int.parse("1");
                                      } else {
                                        porcentaje = int.parse(text);
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        if(porcentaje >= 100) {
                                          return;
                                        } else {
                                          setState(() {
                                            porcentaje += 5;
                                            porcentajeController.text = "${porcentaje.toString()}%";
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (cantidadpersonas <= 0) {
                                            return;
                                          } else {
                                            cantidadpersonas--;
                                            cantidadPersonasController.text = cantidadpersonas.toString();
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    controller: cantidadPersonasController,
                                    inputFormatters: [
                                      Formatos.numeros(),
                                    ],
                                    textAlign: TextAlign.center,
                                    showCursor: true,
                                    onEditingComplete: () {  },
                                    onChanged: (String text) {
                                      if (text.trim() == ""){
                                        cantidadpersonas = int.parse("1");
                                      } else {
                                        cantidadpersonas = int.parse(text);
                                      }
                                    },
                                    onSubmitted: (String text) {
                                      if (text.trim() == ""){
                                        cantidadpersonas = int.parse("1");
                                      } else {
                                        cantidadpersonas = int.parse(text);
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          cantidadpersonas++;
                                          cantidadPersonasController.text = cantidadpersonas.toString();
                                        });
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: cantidadDineroController.text == "" ? null : () {
                              if (llaveForm.currentState!.validate()) {
                                int cantidadFinal = int.parse(cantidadDineroController.text);

                                setState(() {
                                  resultadoPropina = (cantidadFinal * (porcentaje/100));
                                  resultadoPagoPorPersona = (resultadoPropina + cantidadFinal) / cantidadpersonas;
                                  resultadoPagoTotal = (resultadoPropina + cantidadFinal);
                                });

                              }
                            },
                            child: const Text("Calcular"),
                          ),
                          const SizedBox(height: 50,),
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child: Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.monetization_on),
                                          title: Text("Propina: \$$resultadoPropina"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child: Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.monetization_on),
                                          title: Text("Cada persona paga: \$$resultadoPagoPorPersona"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child: Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.monetization_on),
                                          title: Text("Pago total: \$$resultadoPagoTotal"),
                                        ),
                                      ),
                                    ),
                                  ),
                            
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void validar() {
    llaveForm.currentState!.validate();
  }
}
