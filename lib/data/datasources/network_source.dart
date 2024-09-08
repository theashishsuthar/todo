import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async';


abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChange; 
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  late bool _isConnected = false;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();

  NetworkInfoImpl(this.connectivity)  {
   
   _initializeConnectionStatus();

    
    _subscription = connectivity.onConnectivityChanged.listen(( List<ConnectivityResult> result) {
      final hasConnection = result.any((e)=> e !=  ConnectivityResult.none) ;
      if (hasConnection != _isConnected) {
        _isConnected = hasConnection;
        _connectionChangeController.add(_isConnected);
      }
    });
  }

  Future<void> _initializeConnectionStatus() async {
    final connectivityResult = await connectivity.checkConnectivity();
    _isConnected = connectivityResult.any((e)=> e  != ConnectivityResult.none );
    _connectionChangeController.add(_isConnected);
  }

  @override
  Future<bool> get isConnected async {
    return _isConnected;
  }

  @override
  Stream<bool> get onConnectionChange => _connectionChangeController.stream;

  void dispose() {
    _subscription?.cancel();
    _connectionChangeController.close();
  }
}
