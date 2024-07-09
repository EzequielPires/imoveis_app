import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.imoveis.portalcatalao.com.br/',));

  Future<Map<String, dynamic>> get(String path, Map<String, String>? headers) async {
    var response = await dio.get(path, options: Options(headers: headers ?? {
      "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwOGI2NDlhOS1hMjAwLTQ3OWQtYjcyNC02YzNmM2ZjZGViYWQiLCJuYW1lIjoiU2F2YW5hIGltw7N2ZWlzIiwiZW1haWwiOiJjb250YXRvQHNhdmFuYWltb3ZlaXMuY29tLmJyIiwiaXNSZWFsRXN0YXRlIjp0cnVlLCJpYXQiOjE3MTk5Mjg0MTV9.D_sCtjSbFEkGPzp7SVRJW0aBp5Fa6Li5NYbcofN3hOQ"
    }));

    return response.data;
  }

  Future<Map<String, dynamic>> post(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.post(path, data: data, options: Options(headers: headers));

    return response.data;
  }

  Future<Map<String, dynamic>> patch(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.patch(path, data: data, options: Options(headers: headers));

    return response.data;
  }
  
  Future<Map<String, dynamic>> delete(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.delete(path, data: data, options: Options(headers: headers));

    return response.data;
  }

  Future<Map<String, dynamic>> patchForm(String path, FormData? data, Map<String, dynamic>? headers) async {
    var response = await dio.patch(path, data: data, options: Options(headers: headers));

    return response.data;
  }
}
