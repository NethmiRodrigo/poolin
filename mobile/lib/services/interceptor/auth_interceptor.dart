import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // endpoints that don't requre a token
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
      // if the endpoint is matched the list skip adding the token
      options.headers.addAll({
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    return handler.next(options);
    }

    // load your token here and pass to the header
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'TOKEN');

    options.headers.addAll({
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Authorization': token,
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
