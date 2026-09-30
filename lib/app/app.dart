import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:order_rider/app/router.dart';
import 'package:order_rider/app/theme/app_theme.dart';

class OrderRiderApp extends ConsumerWidget {
  const OrderRiderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final appTheme = ref.watch(appThemeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Order Rider',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      themeMode: themeMode,
      theme: AppTheme.light(appTheme),
      darkTheme: AppTheme.dark(appTheme),
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
