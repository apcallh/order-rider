import 'package:flutter/material.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(title: const Text('جلسات العمل')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: AppColors.primaryBlue, size: 18),
                    const SizedBox(width: 8),
                    Text('${28 - i} سبتمبر 2026',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    const Spacer(),
                    Text('${9 - i}h ${15 + i}m',
                        style: const TextStyle(
                            color: AppColors.textSecondaryDark, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('08:30 → ${17 + i}:45',
                    style: const TextStyle(
                        color: AppColors.textSecondaryDark, fontSize: 13)),
                const Divider(height: 20, color: Colors.white12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الطلبات',
                              style: TextStyle(
                                  color: AppColors.textSecondaryDark,
                                  fontSize: 11)),
                          Text('${18 + i * 2}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الإجمالي',
                              style: TextStyle(
                                  color: AppColors.textSecondaryDark,
                                  fontSize: 11)),
                          Text('${(207 + i * 23).toStringAsFixed(0)} QAR',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الصافي',
                              style: TextStyle(
                                  color: AppColors.textSecondaryDark,
                                  fontSize: 11)),
                          Text('${(142 + i * 18).toStringAsFixed(0)} QAR',
                              style: const TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
