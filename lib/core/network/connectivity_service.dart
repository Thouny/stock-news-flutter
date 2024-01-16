import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectionService {
  const ConnectionService();

  Future<bool> get isConnected;
}

class ConnectionServiceImpl extends ConnectionService {
  final Connectivity _connectivity;

  ConnectionServiceImpl(Connectivity connectivity)
      : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    final status = await _connectivity.checkConnectivity();
    switch (status) {
      case ConnectivityResult.none:
        return false;
      default:
        return true;
    }
  }
}
