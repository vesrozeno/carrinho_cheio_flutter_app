import 'package:dio/dio.dart';
import 'dart:developer';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('''
┌────── REQUEST ──────
│ URL: ${options.uri}
│ METHOD: ${options.method}
│ HEADERS: ${options.headers}
│ DATA: ${options.data}
│ PARAMS: ${options.queryParameters}
└─────────────────────
''');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('''
┌────── RESPONSE ──────
│ URL: ${response.requestOptions.uri}
│ STATUS: ${response.statusCode}
│ DATA: ${response.data}
└──────────────────────
''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('''
┌────── ERROR ──────
│ URL: ${err.requestOptions.uri}
│ STATUS: ${err.response?.statusCode}
│ MESSAGE: ${err.message}
│ DATA: ${err.response?.data}
└───────────────────
''');

    super.onError(err, handler);
  }
}
