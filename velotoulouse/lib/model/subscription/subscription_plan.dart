class SubscriptionPlan {
  final String id;
  final String name;
  final int price;
  final String period;
  final String duration;
  final int freeMinutes;
  final String? badge;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.duration,
    required this.freeMinutes,
    this.badge,
  });

  String get formattedPrice => '€$price / $period';

  String get freeRideLabel => 'First $freeMinutes min';

  Duration get bonusDuration => Duration(minutes: freeMinutes);
}
