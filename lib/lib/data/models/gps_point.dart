import 'package:latlong2/latlong.dart';

class GpsPoint {
  final String id;
  final String sessionId;
  final String? orderId;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double speed;
  final double bearing;
  final DateTime timestamp;
  final bool isAccepted;
  final String? rejectionReason;

  const GpsPoint({
    required this.id,
    required this.sessionId,
    this.orderId,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.speed = 0,
    this.bearing = 0,
    required this.timestamp,
    this.isAccepted = false,
    this.rejectionReason,
  });

  LatLng get latLng => LatLng(latitude, longitude);
}
