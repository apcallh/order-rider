import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class AppUtils {
  static double calculateDistance(LatLng p1, LatLng p2) {
    const Distance d = Distance();
    return d.as(LengthUnit.Meter, p1, p2);
  }

  static String formatCurrency(double amount, {String currency = 'QAR'}) {
    final f = NumberFormat('#,##0.00', 'en_US');
    return '${f.format(amount)} $currency';
  }

  static String formatDistance(double meters) {
    if (meters < 1000) return '${meters.toStringAsFixed(0)} m';
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }

  static String formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  static String formatTime(DateTime dt) => DateFormat.jm('ar').format(dt);

  static String formatDate(DateTime dt) => DateFormat.yMMMMd('ar').format(dt);

  static String generateOrderNumber() {
    return '#${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
  }
}
