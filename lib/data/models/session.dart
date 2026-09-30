class WorkSession {
  final String id;
  final String userId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String status;
  final double rawDistanceMeters;
  final double? manualDistanceMeters;
  final String? notes;

  const WorkSession({
    required this.id,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    this.status = 'active',
    this.rawDistanceMeters = 0,
    this.manualDistanceMeters,
    this.notes,
  });

  Duration get duration => (endedAt ?? DateTime.now()).difference(startedAt);
  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';

  WorkSession copyWith({
    DateTime? endedAt,
    String? status,
    double? rawDistanceMeters,
    double? manualDistanceMeters,
    String? notes,
  }) =>
      WorkSession(
        id: id,
        userId: userId,
        startedAt: startedAt,
        endedAt: endedAt ?? this.endedAt,
        status: status ?? this.status,
        rawDistanceMeters: rawDistanceMeters ?? this.rawDistanceMeters,
        manualDistanceMeters:
            manualDistanceMeters ?? this.manualDistanceMeters,
        notes: notes ?? this.notes,
      );
}
