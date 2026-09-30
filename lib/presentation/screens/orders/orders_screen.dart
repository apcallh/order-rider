import 'package:flutter/material.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: const Text('الطلبات'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: AppColors.primaryBlue.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('#40000${i + 1}',
                          style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ),
                    const Spacer(),
                    Text('${13 + i}:${42 + i}',
                        style: const TextStyle(
                            color: AppColors.textSecondaryDark, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.attach_money,
                        color: AppColors.success, size: 18),
                    const SizedBox(width: 6),
                    Text('${(11.5 + i * 0.5).toStringAsFixed(2)} QAR',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const Icon(Icons.timer_outlined,
                        color: AppColors.primaryBlue, size: 18),
                    const SizedBox(width: 6),
                    Text('${2 + i}m',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Divider(height: 20, color: Colors.white12),
                Row(
                  children: [
                    const Text('صافي بعد الوقود',
                        style: TextStyle(
                            color: AppColors.textSecondaryDark, fontSize: 13)),
                    const Spacer(),
                    Text('${(11.29 - i * 0.05).toStringAsFixed(2)} QAR',
                        style: const TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('طلب جديد'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }
}
