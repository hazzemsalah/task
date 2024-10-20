import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  DioClient(this.dio) {
    dio.options.baseUrl = baseUrl;
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> delete(String path) async {
    return await dio.delete(path);
  }
}
