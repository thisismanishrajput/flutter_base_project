import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstraction for checking internet and connectivity state.
abstract class NetworkInfo {
  /// Returns true when internet is currently reachable.
  Future<bool> get isConnected;

  /// Emits internet availability changes over time.
  Stream<bool> get connectionStream;
}

/// Connectivity-based [NetworkInfo] implementation.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({
    required Connectivity connectivity,
    required InternetConnection internetConnection,
  }) : _connectivity = connectivity,
       _internetConnection = internetConnection;

  final Connectivity _connectivity;
  final InternetConnection _internetConnection;

  @override
  Future<bool> get isConnected async {
    // First check transport state (wifi/mobile/ethernet), then verify actual
    // internet accessibility.
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) {
      return false;
    }
    return _internetConnection.hasInternetAccess;
  }

  @override
  Stream<bool> get connectionStream {
    return _connectivity.onConnectivityChanged.asyncMap((
      List<ConnectivityResult> results,
    ) async {
      if (results.contains(ConnectivityResult.none)) {
        return false;
      }
      return _internetConnection.hasInternetAccess;
    });
  }
}
