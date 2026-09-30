import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:order_rider/app/app.dart';
import 'package:order_rider/core/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (AppConstants.supabaseUrl.isNotEmpty &&
        AppConstants.supabaseAnonKey.isNotEmpty) {
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        anonKey: AppConstants.supabaseAnonKey,
      );
    }
  } catch (e) {
    debugPrint('Supabase init skipped: $e');
  }

  runApp(const ProviderScope(child: OrderRiderApp()));
}
