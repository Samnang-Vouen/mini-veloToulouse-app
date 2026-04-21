import 'package:velotoulouse/model/subscription/subscription_plan.dart';

class UserSubscription {
  final SubscriptionPlan plan;
  final DateTime startDate;

  final Duration bonusDuration;

  const UserSubscription({
    required this.plan,
    required this.startDate,
    this.bonusDuration = const Duration(minutes: 30),
  });

  DateTime _baseEndDate() {
    switch (plan.period) {
      case 'day':
        return startDate.add(const Duration(days: 1));

      case 'month':
        return DateTime(startDate.year, startDate.month + 1, startDate.day);

      case 'year':
        return DateTime(startDate.year + 1, startDate.month, startDate.day);

      default:
        return startDate;
    }
  }

  DateTime get endDate => _baseEndDate().add(bonusDuration);

  bool get isActive => endDate.isAfter(DateTime.now());

  String get formattedEndLabel {
    final end = endDate;
    final hour = end.hour % 12 == 0 ? 12 : end.hour % 12;
    final minute = end.minute.toString().padLeft(2, '0');
    final amPm = end.hour < 12 ? 'am' : 'pm';

    final day = end.day.toString().padLeft(2, '0');
    final month = end.month.toString().padLeft(2, '0');

    return 'until $day/$month/${end.year} $hour:$minute$amPm';
  }
}
