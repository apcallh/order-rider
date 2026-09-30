import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pc = PageController();
  int _i = 0;

  final pages = const [
    (Icons.map_outlined, 'خرائط تفاعلية',
        'تصفح خرائط OpenStreetMap مجاناً بدون أي مفتاح API.', AppColors.primaryBlue),
    (Icons.gps_fixed, 'تتبع GPS دقيق',
        'تتبع موقعك تلقائياً مع فلترة متقدمة تمنع القفزات الشاذة.', AppColors.success),
    (Icons.analytics_outlined, 'تحليلات ذكية',
        'تابع أرباحك اليومية والأسبوعية والشهرية.', AppColors.warning),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('تخطي'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pc,
                onPageChanged: (v) => setState(() => _i = v),
                itemCount: pages.length,
                itemBuilder: (_, idx) {
                  final p = pages[idx];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: p.$4.withOpacity(0.15),
                          ),
                          child: Icon(p.$1, size: 80, color: p.$4),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          p.$2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          p.$3,
                          style: const TextStyle(
                            color: AppColors.textSecondaryDark,
                            fontSize: 16,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _i == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _i == i
                        ? AppColors.primaryBlue
                        : AppColors.textSecondaryDark.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: ElevatedButton(
                onPressed: () {
                  if (_i < pages.length - 1) {
                    _pc.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.go('/login');
                  }
                },
                child: Text(_i < pages.length - 1 ? 'التالي' : 'ابدأ الآن'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
