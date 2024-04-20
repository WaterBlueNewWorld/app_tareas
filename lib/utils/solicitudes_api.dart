import 'package:dio/dio.dart';
import 'package:lista_tareas/models/productos_model.dart';

class SolicitudesApi {
  final String url;
  final Dio _dio = Dio();

  SolicitudesApi({required this.url});

  Future<Productos> obtenerProductos() async {
    try {
      Response res = await _dio.get(
        url,
      );

      return Productos.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

}