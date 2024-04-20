import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lista_tareas/utils/solicitudes_api.dart';

import '../../models/productos_model.dart';

class ProductosApi extends StatefulWidget {
  const ProductosApi({super.key});

  @override
  State<ProductosApi> createState() => _ProductosApiState();
}

class _ProductosApiState extends State<ProductosApi> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: SolicitudesApi(url: "https://dummyjson.com/products").obtenerProductos(),
                builder: (ctx, snapshot) {
                  Widget child = const SizedBox();
                  if (snapshot.connectionState != ConnectionState.done) {
                    child = const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Cargando",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    if (kDebugMode) {
                      debugPrint(snapshot.error.toString());
                    }
                    child = const Center(
                      child: Text(
                        "Sin productos",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    Productos productos =
                    snapshot.data as Productos;
                    if (productos.products.isNotEmpty) {
                      child = Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 120,
                            child: GridView.builder(
                              itemCount: productos.products.length,
                              itemBuilder: (ctx, index) {
                                return Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(productos.products[index].thumbnail, fit: BoxFit.fill, height: 40, width: 200,),
                                      Expanded(
                                        child: ListTile(
                                          key: UniqueKey(),
                                          title:
                                          Text(productos.products[index].title),
                                          subtitle: Text(
                                            productos.products[index].brand,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                mainAxisExtent: 120,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      child = const Center(
                        child: Text(
                          "Sin productos",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      );
                    }
                  }
                  return child;
                },
              ),
            ]
        ),
      ],
    );
  }
}
