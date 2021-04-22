import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mcaio/app/app_bloc.dart';
import 'package:mcaio/config/constants.dart';
import 'package:mcaio/helpers/dio_logger.dart';
import 'package:mime/mime.dart';
import 'package:mcaio/extensions/file_extension.dart';

class Method {
  static const GET = 'GET';
  static const POST = 'POST';
  static const PUT = 'PUT';
  static const DELETE = 'DELETE';
}

class Api {
  final Dio client = new Dio();

  Api() {
    client.interceptors.add(DioLogger());
  }

  void close() => client.close();

  // Request with token
  Future<Map> requestWithToken({
    String method = Method.GET,
    String url = '',
    String token,
    dynamic params,
    Map<String, String> headers = const {},
  }) async {
    String _token = token ?? AppState.accessToken;

    if (_token == null) {
      throw new Exception("Token is null");
    }

    return request(
      headers: {...headers ?? {} , 'Authorization': 'Bearer $_token'},
      method: method,
      params: params ?? {},
      url: url,
    );
  }

  Future<Map> request({
    String method = Method.GET,
    String url = '',
    dynamic params,
    Map<String, String> headers,
  }) async {
    try {
      if(method == Method.GET && params.length > 0) {
        List<String> queryParams = [];
        params.forEach((key, value) {
          if(value != null) {
            queryParams.add('$key=$value');
          }
        });
        if(url.contains('&')) {
          url += '&' + queryParams.join('&');
        } else {
          url += '?' + queryParams.join('&');
        }
      }

      Response response = await client.request(
        url,
        options: Options(
          method: method,
          headers: {...headers ?? {}},
        ),
        data: method == Method.GET ? {} : params,
        // onSendProgress: (count, total) {
        //   print('$count/$total');
        // }
      )
          .timeout(Duration(seconds: CONNECT_TIMEOUT));

      client.close();
      return {
        'status': true,
        'data': response.data['data'],
        "message": [response.data["message"] ?? ""]
      };
    } on DioError catch (e) {
      if(e.response == null) {
        return {
          "status": false,
          "error": "server_error",
          "message": ["Server error"]
        };
      }
      var resData = e.response.data;
      return {
        'status': false,
        'error': resData['error'],
        'message': resData['message'] == null
            ? [resData['error']]
            : resData['message'] is String
            ? [resData['message']]
            : resData['message']
      };
    } catch (e) {
      client.close();
      //check has internet connection
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('Error: ${e.stackTrace}');
        return {
          "status": false,
          "error": "server_error",
          "message": ["Server error"]
        };
      }

      print('Error: Network!');
      return {
        "status": false,
        "error": "network_error",
        "message": "Network error"
      };
    }
  }

  // multipartRequest
  Future<dynamic> multipartRequest({
    String method,
    bool withToken = true,
    String url,
    Map params = const {},
    Map<String, String> headers = const {},
    Function(int, int) onProgress,
  }) async {
    FormData formData = FormData();

    params.forEach((key, value) {
      if (value is File) {
        List<String> mimeType = lookupMimeType(value.path).split('/');
        print('File ${value.name}: ' + mimeType.toString());
        formData.files.add(MapEntry(
          key,
          MultipartFile.fromFileSync(
            value.path,
            filename: value.name,
            contentType: MediaType(mimeType.first, mimeType.last),
          ),
        ));
      } else if (value is List<File>) {
        formData.files.addAll(value.map((file) {
          List<String> mimeType = lookupMimeType(file.path).split('/');
          print('File ${file.name}: ' + mimeType.toString());
          return MapEntry(
            key,
            MultipartFile.fromFileSync(
              file.path,
              filename: file.name,
              contentType: MediaType(mimeType.first, mimeType.last),
            ),
          );
        }));
      } else {
        formData.fields.add(MapEntry(key, value));
      }
    });

    if (withToken) {
      return this.requestWithToken(
        headers: headers,
        method: method,
        url: url,
        params: formData,
      );
    }
    return this.request(
      headers: headers,
      method: method,
      url: url,
      params: formData,
    );
  }

  // downloadFile
  Future<String> downloadFile(String fileName,
      {String savePath,
        Function(int receivedBytes, int totalBytes) onDownloadProgress}) async {
    final httpClient = new HttpClient();
    String downloadUrl = "<Download URl>".replaceFirst('{FILENAME}', fileName);

    final request = await httpClient.getUrl(Uri.parse(downloadUrl));
    request.headers
        .add(HttpHeaders.contentTypeHeader, "application/octet-stream");

    var httpResponse = await request.close();

    int byteCount = 0;
    int totalBytes = httpResponse.contentLength;

    //open new file
    File file = new File(savePath);
    var raf = file.openSync(mode: FileMode.write);

    Completer completer = new Completer<String>();

    httpResponse.listen((data) {
        byteCount += data.length;
        raf.writeFromSync(data);

        if (onDownloadProgress != null) {
          onDownloadProgress(byteCount, totalBytes);
        }
      },
      onDone: () {
        raf.closeSync();
        completer.complete(file.path);
      },
      onError: (e) {
        raf.closeSync();
        file.deleteSync();
        completer.completeError(e);
      },
      cancelOnError: true,
    );

    return completer.future;
  }
}
