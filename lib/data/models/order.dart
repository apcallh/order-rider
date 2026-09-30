class Order {
  final String id;
  final String sessionId;
  final String orderNumber;
  final DateTime startedAt;
  final DateTime? completedAt;
  final double durationSeconds;
  final double rawDistanceMeters;
  final double earnings;
  final double bonus;
  final double tip;
  final double fuelLiters;
  final double fuelCost;
  final double netIncome;
  final String? notes;
  final String status;

  const Order({
    required this.id,
    required this.sessionId,
    required this.orderNumber,
    required this.startedAt,
    this.completedAt,
    this.durationSeconds = 0,
    this.rawDistanceMeters = 0,
    this.earnings = 11.5,
    this.bonus = 0,
    this.tip = 0,
    this.fuelLiters = 0,
    this.fuelCost = 0,
    this.netIncome = 0,
    this.notes,
    this.status = 'active',
  });

  double get grossIncome => earnings + bonus + tip;
  Duration get duration => Duration(seconds: durationSeconds.round());

  Order copyWith({
    DateTime? completedAt,
    double? durationSeconds,
    double? rawDistanceMeters,
    double? earnings,
    double? bonus,
    double? tip,
    double? fuelLiters,
    double? fuelCost,
    double? netIncome,
    String? notes,
    String? status,
  }) =>
      Order(
        id: id,
        sessionId: sessionId,
        orderNumber: orderNumber,
        startedAt: startedAt,
        completedAt: completedAt ?? this.completedAt,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        rawDistanceMeters: rawDistanceMeters ?? this.rawDistanceMeters,
        earnings: earnings ?? this.earnings,
        bonus: bonus ?? this.bonus,
        tip: tip ?? this.tip,
        fuelLiters: fuelLiters ?? this.fuelLiters,
        fuelCost: fuelCost ?? this.fuelCost,
        netIncome: netIncome ?? this.netIncome,
        notes: notes ?? this.notes,
        status: status ?? this.status,
      );
}
