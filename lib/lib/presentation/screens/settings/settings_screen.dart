import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_rider/app/theme/app_colors.dart';
import 'package:order_rider/app/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeStyle = ref.watch(appThemeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _H('المظهر', Icons.palette),
          _T(
            icon: Icons.brightness_6,
            title: 'وضع السمة',
            subtitle: _mn(themeMode),
            onTap: () => _dlg(context, ref, 'وضع السمة', [
              (
                'داكن',
                () => ref.read(themeModeProvider.notifier).state =
                    ThemeMode.dark
              ),
              (
                'فاتح',
                () => ref.read(themeModeProvider.notifier).state =
                    ThemeMode.light
              ),
              (
                'النظام',
                () => ref.read(themeModeProvider.notifier).state =
                    ThemeMode.system
              ),
            ]),
          ),
          _T(
            icon: Icons.style,
            title: 'نمط الواجهة',
            subtitle: _sn(themeStyle),
            onTap: () => _dlg(context, ref, 'نمط الواجهة', [
              (
                'داكن عصري',
                () => ref.read(appThemeProvider.notifier).state =
                    AppThemeStyle.darkModern
              ),
              (
                'فاتح نظيف',
                () => ref.read(appThemeProvider.notifier).state =
                    AppThemeStyle.lightClean
              ),
              (
                'Material You',
                () => ref.read(appThemeProvider.notifier).state =
                    AppThemeStyle.materialYou
              ),
              (
                'Liquid Glass',
                () => ref.read(appThemeProvider.notifier).state =
                    AppThemeStyle.liquidGlass
              ),
            ]),
          ),
          const SizedBox(height: 16),
          const _H('اللغة', Icons.language),
          _T(
            icon: Icons.translate,
            title: 'اللغة',
            subtitle: locale.languageCode == 'ar' ? 'العربية' : 'English',
            onTap: () => _dlg(context, ref, 'اللغة', [
              (
                'العربية',
                () => ref.read(localeProvider.notifier).state =
                    const Locale('ar')
              ),
              (
                'English',
                () => ref.read(localeProvider.notifier).state =
                    const Locale('en')
              ),
            ]),
          ),
          const SizedBox(height: 16),
          const _H('العمل', Icons.work),
          const _T(
              icon: Icons.attach_money,
              title: 'سعر الطلب الافتراضي',
              subtitle: '11.50 QAR'),
          const _T(
              icon: Icons.flag, title: 'هدف اليوم', subtitle: '25 طلب'),
          const _T(
              icon: Icons.currency_exchange,
              title: 'العملة',
              subtitle: 'QAR'),
          const SizedBox(height: 16),
          const _H('السيارة والوقود', Icons.directions_car),
          const _T(
              icon: Icons.local_gas_station,
              title: 'كفاءة الوقود',
              subtitle: '11.5 كم/لتر'),
          const _T(
              icon: Icons.attach_money,
              title: 'سعر اللتر',
              subtitle: '2.00 QAR'),
          const _T(
              icon: Icons.battery_charging_full,
              title: 'سعة الخزان',
              subtitle: '60 لتر'),
          const SizedBox(height: 16),
          const _H('GPS', Icons.gps_fixed),
          const _T(
              icon: Icons.high_quality,
              title: 'دقة GPS',
              subtitle: 'عالية'),
          const _T(
              icon: Icons.speed,
              title: 'حد السرعة القصوى',
              subtitle: '200 كم/س'),
          const _T(
              icon: Icons.filter_alt,
              title: 'فلترة القفزات',
              subtitle: 'مفعّلة'),
          const SizedBox(height: 16),
          const _H('البيانات', Icons.storage),
          const _T(
              icon: Icons.backup, title: 'نسخ احتياطي', subtitle: 'JSON'),
          const _T(
              icon: Icons.restore,
              title: 'استعادة',
              subtitle: 'من ملف JSON'),
          const _T(
              icon: Icons.cloud_sync,
              title: 'المزامنة السحابية',
              subtitle: 'Supabase'),
          const _T(
            icon: Icons.delete_forever,
            title: 'حذف كل البيانات',
            subtitle: 'لا يمكن التراجع',
            color: AppColors.danger,
          ),
          const SizedBox(height: 16),
          const _H('حول', Icons.info),
          const _T(
              icon: Icons.apps,
              title: 'إصدار التطبيق',
              subtitle: '1.0.0'),
          const _T(
              icon: Icons.map,
              title: 'مزود الخرائط',
              subtitle: 'OpenStreetMap'),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _mn(ThemeMode m) =>
      m == ThemeMode.dark ? 'داكن' : m == ThemeMode.light ? 'فاتح' : 'النظام';

  String _sn(AppThemeStyle s) {
    switch (s) {
      case AppThemeStyle.darkModern:
        return 'داكن عصري';
      case AppThemeStyle.lightClean:
        return 'فاتح نظيف';
      case AppThemeStyle.materialYou:
        return 'Material You';
      case AppThemeStyle.liquidGlass:
        return 'Liquid Glass';
    }
  }

  void _dlg(
    BuildContext context,
    WidgetRef ref,
    String title,
    List<(String, VoidCallback)> items,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          ...items.map(
            (e) => ListTile(
              title:
                  Text(e.$1, style: const TextStyle(color: Colors.white)),
              onTap: () {
                e.$2();
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _H extends StatelessWidget {
  final String t;
  final IconData i;
  const _H(this.t, this.i);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(i, color: AppColors.primaryBlue, size: 18),
          const SizedBox(width: 8),
          Text(t,
              style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

class _T extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? color;

  const _T({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(icon, color: color ?? AppColors.primaryBlue, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: color ?? Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                              color: AppColors.textSecondaryDark,
                              fontSize: 12)),
                    ],
                  ),
                ),
                if (onTap != null)
                  const Icon(Icons.arrow_forward_ios,
                      color: AppColors.textSecondaryDark, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
