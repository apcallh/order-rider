class AppConstants {
  static const String supabaseUrl =
      String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String osmUserAgent = 'com.orderrider.app';

  static const String defaultCurrency = 'QAR';
  static const double defaultOrderRate = 11.50;
  static const double defaultFuelEfficiency = 11.5;
  static const double defaultFuelPrice = 2.00;

  static const double gpsAccuracyThreshold = 30.0;
  static const double maxSpeedThreshold = 200.0;
  static const double minMovementMeters = 5.0;
}
