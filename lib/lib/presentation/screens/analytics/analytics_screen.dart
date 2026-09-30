import 'package:flutter/material.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selected = 0;
  final _ranges = ['اليوم', 'الأسبوع', 'الشهر', 'مخصص'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(title: const Text('التحليلات')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: List.generate(_ranges.length, (i) {
                  final sel = i == _selected;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selected = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              sel ? AppColors.primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(_ranges[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: sel
                                    ? Colors.white
                                    : AppColors.textSecondaryDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.deepBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('إجمالي الأرباح',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 8),
                  const Text('1,245.50 QAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _T(label: 'الطلبات', value: '108'),
                      _T(label: 'المسافة', value: '487 km'),
                      _T(label: 'الوقود', value: '42.4 L'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('الأرباح اليومية',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (i) {
                  final hs = [40.0, 80.0, 60.0, 120.0, 100.0, 140.0, 110.0];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: hs[i],
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryBlue,
                              AppColors.glowBlue
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'][i],
                          style: const TextStyle(
                              color: AppColors.textSecondaryDark,
                              fontSize: 11)),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _D(
                    title: 'متوسط/طلب',
                    value: '11.53 QAR',
                    icon: Icons.trending_up,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _D(
                    title: 'متوسط/كم',
                    value: '2.56 QAR',
                    icon: Icons.route,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _D(
                    title: 'متوسط/ساعة',
                    value: '18.72 QAR',
                    icon: Icons.timer,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _D(
                    title: 'صافي اليوم',
                    value: '198.25 QAR',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.glowBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _T extends StatelessWidget {
  final String label;
  final String value;

  const _T({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ],
      ),
    );
  }
}

class _D extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _D({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 12),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 2),
          Text(title,
              style: const TextStyle(
                  color: AppColors.textSecondaryDark, fontSize: 11)),
        ],
      ),
    );
  }
}
