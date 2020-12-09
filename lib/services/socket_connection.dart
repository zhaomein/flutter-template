import 'package:com.ourlife.app/config/api_constants.dart';
import 'package:com.ourlife.app/extensions/dynamic_extension.dart';
import 'package:device_id/device_id.dart';
import 'package:socket_io_client/socket_io_client.dart';

typedef ListenFuntion = Function(Map message);

class SocketConnection {

  Socket _socket;
  String _token;

  bool get connected => _socket != null ? _socket.connected : false;
  Socket get socket => _socket;

  //create singleton
  static final SocketConnection _singleton = new SocketConnection._internal();
  SocketConnection._internal();
  static SocketConnection getInstance() => _singleton;

  static SocketConnection initialize(String token) {
    _singleton._token = token;
    return _singleton;
  }

  void disconnect() {
    _socket.disconnect();
  }

  void connect() async {
    if(_token == null) {
      throw Exception('Socket not initialized.');
    }

    print('$tag: connecting to server...');
    final deviceId = await DeviceId.getID;

    _socket = io(BASE_URL, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {
        'token': _token,
        'device_id': deviceId
      }
    });

    _socket.on('connect', (info) {
      print('$tag: Connected to server!');
    });

    _socket.on('connect_error', (err) {
      print('$tag: connect_error - $err');
    });

    _socket.on('error', (err) {
      print('$tag: error - $err');
    });

    _socket.on('disconnect', (err) {
      print('$tag: disconnect - $err');
    });

    _socket.on('connect_timeout', (e) {
      print('$tag: connect_timeout - $e');
    });
  }

}
