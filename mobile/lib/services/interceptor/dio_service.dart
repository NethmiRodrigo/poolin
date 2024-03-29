import 'package:dio/dio.dart';
import 'package:poolin/services/interceptor/auth_interceptor.dart';

class DioService {
  static var dio = Dio();

  static Dio getService() {
    dio.interceptors
      ..add(LogInterceptor())
      ..add(AuthInterceptor());

    return dio;
  }
}
