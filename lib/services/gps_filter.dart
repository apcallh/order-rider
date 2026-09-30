import 'package:latlong2/latlong.dart';
import 'package:order_rider/core/constants.dart';
import 'package:order_rider/core/utils.dart';

class GpsFilter {
  LatLng? _lastAccepted;
  DateTime? _lastTimestamp;
  double _lastAcceptedSpeed = 0;

  bool isPointValid({
    required LatLng point,
    required double accuracy,
    required DateTime timestamp,
    required double reportedSpeed,
  }) {
    if (point.latitude.abs() > 90 || point.longitude.abs() > 180) return false;
    if (accuracy > AppConstants.gpsAccuracyThreshold) return false;
    if (timestamp.isAfter(DateTime.now().add(const Duration(seconds: 5)))) {
      return false;
    }

    if (_lastAccepted == null || _lastTimestamp == null) {
      _lastAccepted = point;
      _lastTimestamp = timestamp;
      return true;
    }

    final dist = AppUtils.calculateDistance(_lastAccepted!, point);
    final secs = timestamp.difference(_lastTimestamp!).inSeconds;
    if (secs <= 0) return false;

    final implied = (dist / secs) * 3.6;
    if (implied > AppConstants.maxSpeedThreshold) return false;

    if (dist < AppConstants.minMovementMeters && reportedSpeed < 2) {
      _lastTimestamp = timestamp;
      return false;
    }

    if (reportedSpeed > 0 && _lastAcceptedSpeed > 0) {
      final diff = (reportedSpeed - _lastAcceptedSpeed).abs();
      if (diff > 50 && secs < 10) return false;
    }

    _lastAccepted = point;
    _lastTimestamp = timestamp;
    if (reportedSpeed > 0) _lastAcceptedSpeed = reportedSpeed;
    return true;
  }

  void reset() {
    _lastAccepted = null;
    _lastTimestamp = null;
    _lastAcceptedSpeed = 0;
  }

  double distanceFromLast(LatLng point) {
    if (_lastAccepted == null) return 0;
    return AppUtils.calculateDistance(_lastAccepted!, point);
  }
}
