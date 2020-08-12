import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream
import 'package:connectivity/connectivity.dart';

class InternetConnection {
  
    static final InternetConnection _singleton = new InternetConnection._internal();
    static InternetConnection getInstance() => _singleton;

    InternetConnection._internal();
    
    bool hasConnection = false;
    StreamController connectionChangeController = new StreamController.broadcast();
    final Connectivity _connectivity = Connectivity();

    void initialize() {
        _connectivity.onConnectivityChanged.listen(_connectionChange);
        checkConnection();
    }

    Stream get connectionChange => connectionChangeController.stream;

    void dispose() {
        connectionChangeController.close();
    }

    void _connectionChange(ConnectivityResult result) {
        checkConnection();
    }

    Future<bool> checkConnection() async {
        bool previousConnection = hasConnection;
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              hasConnection = true;
          } else {
              hasConnection = false;
          }
        } catch(_) {
            hasConnection = false;
        }

        if (previousConnection != hasConnection) {
            connectionChangeController.add(hasConnection);
        }

        return hasConnection;
    }
}