import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: const Text('ملفي الشخصي'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.darkCard, AppColors.darkSurface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.primaryBlue, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.person,
                        size: 50, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 14),
                  const Text('أحمد محمد',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('ahmed@example.com',
                      style:
                          TextStyle(color: AppColors.textSecondaryDark)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _B(
                          icon: Icons.star,
                          label: '4.9',
                          color: AppColors.warning),
                      const SizedBox(width: 8),
                      _B(
                          icon: Icons.local_shipping,
                          label: 'سيارة',
                          color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      _B(
                          icon: Icons.verified,
                          label: 'موثق',
                          color: AppColors.success),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _Title('معلومات السيارة'),
            _Info(
                icon: Icons.directions_car,
                label: 'نوع السيارة',
                value: 'تويوتا كامري 2022'),
            _Info(
                icon: Icons.confirmation_number,
                label: 'رقم السيارة',
                value: '123456'),
            _Info(
                icon: Icons.local_gas_station,
                label: 'نوع الوقود',
                value: 'بنزين 91'),
            _Info(
                icon: Icons.speed,
                label: 'كفاءة الوقود',
                value: '11.5 كم/لتر'),
            _Info(
                icon: Icons.attach_money,
                label: 'سعر اللتر',
                value: '2.00 QAR'),
            _Info(
                icon: Icons.battery_charging_full,
                label: 'سعة الخزان',
                value: '60 لتر'),
            const SizedBox(height: 20),
            const _Title('إدارة'),
            _Menu(
              icon: Icons.settings,
              label: 'الإعدادات',
              onTap: () => context.push('/settings'),
            ),
            _Menu(
              icon: Icons.history,
              label: 'جلسات العمل',
              onTap: () => context.push('/sessions'),
            ),
            _Menu(
              icon: Icons.analytics,
              label: 'التحليلات',
              onTap: () => context.push('/analytics'),
            ),
            _Menu(
              icon: Icons.logout,
              label: 'تسجيل خروج',
              onTap: () => context.go('/login'),
              color: AppColors.danger,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String t;
  const _Title(this.t);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(t,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    );
  }
}

class _B extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _B({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _Info({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondaryDark, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _Menu({
    required this.icon,
    required this.label,
    required this.onTap,
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
                Text(label,
                    style: TextStyle(
                        color: color ?? Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
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
