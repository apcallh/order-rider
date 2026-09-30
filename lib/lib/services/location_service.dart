import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:order_rider/services/gps_filter.dart';

class LocationService {
  final GpsFilter _filter = GpsFilter();
  StreamSubscription<Position>? _sub;
  final _ctrl = StreamController<LocationUpdate>.broadcast();

  Stream<LocationUpdate> get stream => _ctrl.stream;

  double _total = 0;
  double get totalDistanceMeters => _total;

  Future<bool> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    var p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }
    return p != LocationPermission.denied &&
        p != LocationPermission.deniedForever;
  }

  Future<void> startTracking() async {
    if (!await requestPermission()) return;
    _filter.reset();
    _total = 0;

    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    _sub = Geolocator.getPositionStream(locationSettings: settings)
        .listen(_onPosition);
  }

  void _onPosition(Position pos) {
    final point = LatLng(pos.latitude, pos.longitude);
    final ok = _filter.isPointValid(
      point: point,
      accuracy: pos.accuracy,
      timestamp: pos.timestamp,
      reportedSpeed: pos.speed * 3.6,
    );
    if (ok) _total += _filter.distanceFromLast(point);

    _ctrl.add(LocationUpdate(
      position: pos,
      latLng: point,
      isValid: ok,
      totalDistanceMeters: _total,
    ));
  }

  Future<void> stopTracking() async {
    await _sub?.cancel();
    _sub = null;
  }

  void dispose() {
    _sub?.cancel();
    _ctrl.close();
  }
}

class LocationUpdate {
  final Position position;
  final LatLng latLng;
  final bool isValid;
  final double totalDistanceMeters;

  LocationUpdate({
    required this.position,
    required this.latLng,
    required this.isValid,
    required this.totalDistanceMeters,
  });

  double get speedKmh => position.speed * 3.6;
}
