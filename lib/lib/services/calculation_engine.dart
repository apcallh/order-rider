import 'package:order_rider/data/models/order.dart';
import 'package:order_rider/data/models/expense.dart';

class CalculationEngine {
  static double calculateFuelLiters({
    required double distanceMeters,
    required double fuelEfficiencyKmPerL,
  }) {
    if (fuelEfficiencyKmPerL <= 0) return 0;
    return (distanceMeters / 1000) / fuelEfficiencyKmPerL;
  }

  static double calculateFuelCost({
    required double fuelLiters,
    required double fuelPricePerL,
  }) {
    if (fuelLiters <= 0 || fuelPricePerL <= 0) return 0;
    return fuelLiters * fuelPricePerL;
  }

  static double calculateOrderNet({
    required Order order,
    required double fuelPricePerL,
    required double fuelEfficiencyKmPerL,
  }) {
    final liters = calculateFuelLiters(
      distanceMeters: order.rawDistanceMeters,
      fuelEfficiencyKmPerL: fuelEfficiencyKmPerL,
    );
    final cost = calculateFuelCost(
      fuelLiters: liters,
      fuelPricePerL: fuelPricePerL,
    );
    return order.grossIncome - cost;
  }

  static double calculateDailyNet({
    required List<Order> orders,
    required List<Expense> expenses,
    required double fuelPricePerL,
    required double fuelEfficiencyKmPerL,
  }) {
    double gross = 0;
    double fuel = 0;
    for (final o in orders) {
      if (o.status != 'completed') continue;
      gross += o.grossIncome;
      fuel += calculateFuelCost(
        fuelLiters: calculateFuelLiters(
          distanceMeters: o.rawDistanceMeters,
          fuelEfficiencyKmPerL: fuelEfficiencyKmPerL,
        ),
        fuelPricePerL: fuelPricePerL,
      );
    }
    double other = 0;
    for (final e in expenses) {
      other += e.amount;
    }
    return gross - fuel - other;
  }

  static double earningsPerOrder(List<Order> orders) {
    final done = orders.where((o) => o.status == 'completed').toList();
    if (done.isEmpty) return 0;
    final total = done.fold<double>(0, (s, o) => s + o.grossIncome);
    return total / done.length;
  }

  static double earningsPerKm(List<Order> orders) {
    final done = orders.where((o) => o.status == 'completed').toList();
    if (done.isEmpty) return 0;
    final total = done.fold<double>(0, (s, o) => s + o.grossIncome);
    final km =
        done.fold<double>(0, (s, o) => s + o.rawDistanceMeters / 1000);
    return km <= 0 ? 0 : total / km;
  }

  static double earningsPerHour(List<Order> orders, Duration duration) {
    final done = orders.where((o) => o.status == 'completed').toList();
    if (done.isEmpty || duration.inMinutes <= 0) return 0;
    final total = done.fold<double>(0, (s, o) => s + o.grossIncome);
    return total / (duration.inMinutes / 60.0);
  }
}
