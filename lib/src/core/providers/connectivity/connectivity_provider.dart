import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Optimized connectivity service with caching to improve performance
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool? _cachedConnectionStatus;
  DateTime? _lastCheckTime;
  final Duration _cacheValidityDuration = const Duration(seconds: 5);

  /// Cached connection check - uses cached value if available and still valid
  Future<bool> isConnected() async {
    // Use cached value if it exists and is recent enough to avoid expensive checks during scrolling
    if (_cachedConnectionStatus != null && _lastCheckTime != null) {
      final elapsed = DateTime.now().difference(_lastCheckTime!);
      if (elapsed < _cacheValidityDuration) {
        return _cachedConnectionStatus!;
      }
    }

    // Perform actual check if cache is invalid or expired
    final connectivityResult = await _connectivity.checkConnectivity();
    _cachedConnectionStatus =
        !connectivityResult.contains(ConnectivityResult.none);
    _lastCheckTime = DateTime.now();
    return _cachedConnectionStatus!;
  }

  /// Get current cached status without performing a check
  bool? get currentStatus => _cachedConnectionStatus;

  // Convert the List<ConnectivityResult> stream to a Stream<bool>
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) {
      final isConnected = !results.contains(ConnectivityResult.none);
      // Update cache when stream provides new value
      _cachedConnectionStatus = isConnected;
      _lastCheckTime = DateTime.now();
      return isConnected;
    });
  }
}

/// Global instance of connectivity service for optimization
final _connectivityServiceInstance = ConnectivityService();

/// Provider for the connectivity service
final connectivityServiceProvider = Provider<ConnectivityService>((_) {
  return _connectivityServiceInstance;
});

/// Stream provider with improved caching for connectivity status changes
final connectivityStreamProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.connectivityStream;
});

/// Optimized provider for immediate connectivity check that uses caching
final connectivityProvider = Provider<bool?>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  final asyncValue = ref.watch(connectivityStreamProvider);

  // Use cached value when available to avoid expensive operations
  return asyncValue.maybeWhen(
    data: (isConnected) => isConnected,
    orElse: () => service.currentStatus ?? false,
  );
});

/// Legacy provider kept for backward compatibility
@Deprecated('Use connectivityProvider instead')
final connectivityFutureProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(connectivityServiceProvider);
  return service.isConnected();
});
