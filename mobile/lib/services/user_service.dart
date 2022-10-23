import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/user';

final dio = DioService.getService();

Future<Response> getUserDetails(int id) async {
  dio.options.baseUrl = baseURL;
  final response = await dio.get("/get/$id");
  return response;
}
