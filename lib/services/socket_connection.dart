import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:web_socket_channel/io.dart';

typedef ListenFuntion = Function(Map message);

class SocketConnection {

  IOWebSocketChannel channel;
  String type;

  StreamController _socketStreamController = new StreamController.broadcast();
  Stream get receiveData => _socketStreamController.stream;
  
  //create singleton
  static final SocketConnection _singleton = new SocketConnection._internal();
  SocketConnection._internal();
  static SocketConnection getInstance() => _singleton;

  void connect() {
    channel = IOWebSocketChannel.connect("<web_socket_url>");
    register();
  }

  void register() async {
    String token = "<Uuser Token>";
    //print('WS - Conecting with token: $token ----------------------------');
    print('WS - Conecting... ----------------------------');

    if(token == null || token.isEmpty) return;

    var data = {
      "type": "register",
      "content": {
        "token": token
      }
    };

    channel.sink.add(json.encode(data));
    print('WS - Conected! -----------------------------');

    channel.stream.listen(
      (dynamic message) {
        print('WS: received data------------------------');
        _socketStreamController.add(json.decode(message));
        //channel.sink.close();
        //print('WS: ${message.toString()} \n-------------------------------'); 
      },
      onDone: () async {
        print('WS - was closed--------------------');
        var connectivityResult = await (Connectivity().checkConnectivity());
        
        if (connectivityResult == ConnectivityResult.mobile || 
          connectivityResult == ConnectivityResult.wifi) {
          print('WS - trying to reconnect-------');
           SocketConnection.getInstance().connect();
        } else {
          print('WS - no internet to reconnect-------');
        }
      },
      onError: (error) {
        print('WS - error $error-------');
      }
    );

  }

  void sendData(String type, Map data) {
    Map sinkData = {
      "type": type,
      "content": data
    };
    channel.sink.add(json.encode(sinkData));
    print(sinkData.toString());
  }

}