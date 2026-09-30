import 'package:flutter/material.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class BankCard extends StatelessWidget {
  final String driverName;
  final double earningsToday;
  final int ordersToday;
  final double distanceToday;
  final double netToday;
  final bool isActive;

  const BankCard({
    super.key,
    required this.driverName,
    required this.earningsToday,
    required this.ordersToday,
    required this.distanceToday,
    required this.netToday,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A1929), Color(0xFF1A2942), Color(0xFF0F2438)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primaryBlue.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryBlue.withOpacity(0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.success.withOpacity(0.2)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.success
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isActive ? 'نشط الآن' : 'غير نشط',
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.success
                                    : Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.local_shipping,
                          color: AppColors.primaryBlue, size: 28),
                    ],
                  ),
                  const Spacer(),
                  const Text('أرباح اليوم',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        earningsToday.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('QAR',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _S(label: 'الطلبات', value: '$ordersToday'),
                      const SizedBox(width: 20),
                      _S(
                          label: 'المسافة',
                          value: '${distanceToday.toStringAsFixed(1)} km'),
                      const SizedBox(width: 20),
                      _S(
                        label: 'صافي',
                        value: '${netToday.toStringAsFixed(0)} QAR',
                        hi: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person,
                          color: Colors.white54, size: 14),
                      const SizedBox(width: 6),
                      Text(driverName,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              letterSpacing: 1)),
                      const Spacer(),
                      const Text('•••• 4821',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              letterSpacing: 1.5)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _S extends StatelessWidget {
  final String label;
  final String value;
  final bool hi;

  const _S({required this.label, required this.value, this.hi = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white60, fontSize: 10)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                color: hi ? AppColors.success : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
