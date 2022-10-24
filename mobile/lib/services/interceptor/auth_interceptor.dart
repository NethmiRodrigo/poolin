import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  String baseURL = '${dotenv.env['API_URL']}/api';
  late BaseOptions options;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // endpoints that don't require a token
    final listOfPaths = <String>[
      '/login',
      '/send-reset-password-email',
      '/verify-password-otp',
      '/reset-password',
      '/verify-credentials',
      '/verify-mobile-num',
      '/verify-email-otp',
      '/verify-sms-otp',
      '/resend-email-otp',
      '/verify-user-info',
    ];

    if (listOfPaths.contains(options.path.toString())) {
      // if the endpoint matched the list, skip adding the cookie
      options.headers.addAll({
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
      return handler.next(options);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('cookie');

    options.headers.addAll({
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'token': 'Token=$cookie',
    });

    return handler.next(options);
  }

  // perform some actions in the response or onError.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
