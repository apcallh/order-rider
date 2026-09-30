class Expense {
  final String id;
  final String? sessionId;
  final String category;
  final double amount;
  final String? description;
  final DateTime date;

  const Expense({
    required this.id,
    this.sessionId,
    required this.category,
    required this.amount,
    this.description,
    required this.date,
  });

  static const List<String> categories = [
    'وقود',
    'صيانة',
    'غسيل',
    'مواقف',
    'هاتف/إنترنت',
    'رسوم طريق',
    'طعام',
    'أخرى',
  ];
}
