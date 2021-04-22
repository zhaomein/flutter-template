import 'dart:async';
import 'package:dio/dio.dart';

class DioLogger extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _printLine(title: 'API Request');
    print('URL: [${options.method}] ${options.path}');
    print('Header: ${options.headers}');
    print('Params: ${options.data}');
    _printLine(newLine: true);
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    _printLine(title: 'API Error');
    print('URL: [${err.requestOptions.method}] ${err.requestOptions.path} ${err.response != null ? '(${err.response.statusCode})' : ''}');
    print('Header: ${err.requestOptions.headers}');
    print('Message: ${err.message}');
    if(err.response != null) {
      print('Response: ${err.response.data}');
    }
    _printLine(newLine: true);
    return super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    _printLine(title: 'API Response');
    print('URL: [${response.requestOptions.method}] ${response.requestOptions.path} (${response.statusCode})');
    print('Data: ${response.data}');
    _printLine(newLine: true);
    return super.onResponse(response, handler);
  }

  _printLine({String title = '', newLine: false}) {
    print('${title.isNotEmpty ? '\n$title ' : ''} ${'-' * (85 - title.length)} ${newLine ? '\n': ''}');
  }
}
