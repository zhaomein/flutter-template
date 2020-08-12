import 'dart:async';
import 'dart:io';
import '../../helpers/progress_multipart_request.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'dart:convert';

enum Method {GET, POST, PUT, DELETE}

const Map<String, String> defaultHeaders = {"Content-Type": "application/json"};

class ApiProvider {

  Client client = new Client();

  void close() => client.close();

  Future<Map> requestWithToken(String token, { Method method = Method.GET, String url = '',
    Map<String, dynamic> params, Map<String, String> apiHeaders }) {   
    return request(
      apiHeaders: {
        ...(apiHeaders ?? {}),
        'Authorization': 'Bearer $token'
      },
      method: method,
      params: params,
      url: url
    );
  }

  Future<Map> request({ Method method = Method.GET, String url = '',
    Map<String, dynamic> params, Map<String, String> apiHeaders = const{} }) async {
      
      Map<String, String > headers  = {
        ...apiHeaders,
        ...defaultHeaders
      };

      Response response;
      debugPrint('$method to: $url\n------------------------------------------------');
      debugPrint('params: '+params.toString());
      //print('user token: ${Store.userToken}');    

      try {
        switch(method) {
          //post method
          case Method.POST: 
            response = await client.post(url, 
              body: json.encode(params), 
              headers: headers
            ).timeout(Duration(seconds: 15));

          break;

          //get method
          case Method.GET:
            List<String> queryParams = [];

            params.forEach((key, value) {
              queryParams.add("$key=$value");
            });

            response = await client.get(
              url + (queryParams.length > 0 ? '?' + queryParams.join("&") : ''),
              headers: headers,
            ).timeout(Duration(seconds: 15));

          break;

          //put method
          case Method.PUT:
            response = await client.put(url, 
              body: json.encode(params), 
              headers: headers
            ).timeout(Duration(seconds: 15));
          break;

            //put method
          case Method.DELETE:
            response = await client.delete(url, 
              headers: headers
            ).timeout(Duration(seconds: 15));
          break;
        }

        client.close();

        debugPrint('Response: ${utf8.decode(response.bodyBytes)} \n---------------------------------');
        print('$method to API: Success!==========');

        Map resData = json.decode(utf8.decode(response.bodyBytes));

        if(response.statusCode >= 400 && response.statusCode <=500) {
          return {
            'status': false,
            'error': resData['error']
          };
        }

        return {
          'status': true,
          'data': resData['data']
        };

      } catch(e) {
        client.close();
        //check has internet
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          print('Error: Server!');
          return {"status": false, "error": "server_error"};
        }

        print('Error: Network!');
        return {"status": false, "error": "network_error"};
      }
  }


  Future<Map> uploadFile({
    File file, String fileFieldName, Method method,
    String url, Map params = const {}, Function(int, int) onProgress
  }) async {

    Completer completer = Completer();

    var request = ProgressMultipartRequest(
        method.toString().split(".").last,
        Uri.parse(url),
        onProgress: onProgress
    );
    print('Upload: Start upload to: $url');

    if(file != null) {
      String fileName = file.path.split("/").last;
      var stream = ByteStream(file.openRead().cast());
      var length = await file.length();

      List<String> mimeType = lookupMimeType(file.path).split('/');
      print('Mime Type: '+mimeType.toString());

      var multipartFile = MultipartFile(
          fileFieldName ?? 'file', stream, length,
          filename: fileName != null ? fileName : basename(file.path),
          contentType: MediaType(mimeType.first, mimeType.last)
      );
      request.files.add(multipartFile);
    }

    print("Params: $params");
    request.fields.addAll(Map<String, String>.from(params));

    try {
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((data) {
        print('Upload response: ' + data.toString());
        final resData = json.decode(data);

        if(response.statusCode >= 400 && response.statusCode <=500) {
          completer.complete({
            'status': false,
            'error': resData['error']
          });
        }
        completer.complete({
          'status': true,
          'data': resData['data']
        });
      });

    } catch(err) {
      print('Error Upload to server: $err');
      client.close();

      //check has internet
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('Error: Server!');
        completer.complete({"status": false, "error": "server_error"});
      }

      print('Error: Network!');
      completer.complete({"status": false, "error": "network_error"});
    }

    return completer.future;
  }


  Future<String> downloadFile(String fileName, {String savePath,
    Function(int receivedBytes, int totalBytes) onDownloadProgress}) async {

    final httpClient = new HttpClient();
    String downloadUrl = "<Download URl>".replaceFirst('{FILENAME}', fileName);

    final request = await httpClient.getUrl(Uri.parse(downloadUrl));
    request.headers.add(HttpHeaders.contentTypeHeader, "application/octet-stream");

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