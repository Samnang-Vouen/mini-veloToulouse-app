import 'package:velotoulouse/model/subscription/subscription_plan.dart';

class SubscriptionPlanDto {
  static final String nameKey = 'name';
  static final String priceKey = 'price';
  static final String periodKey = 'period';
  static final String durationKey = 'duration';
  static final String freeMinutesKey = 'freeMinutes';
  static final String badgeKey = 'badge';

  static SubscriptionPlan fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[priceKey] is int);
    assert(json[periodKey] is String);
    assert(json[durationKey] is String);
    assert(json[freeMinutesKey] is int);

    return SubscriptionPlan(
      id: id,
      name: json[nameKey] as String,
      price: json[priceKey] as int,
      period: json[periodKey] as String,
      duration: json[durationKey] as String,
      freeMinutes: json[freeMinutesKey] as int,
      badge: json[badgeKey] as String?,
    );
  }

  Map<String, dynamic> toJson(SubscriptionPlan plan) {
    return {
      nameKey: plan.name,
      priceKey: plan.price,
      periodKey: plan.period,
      durationKey: plan.duration,
      freeMinutesKey: plan.freeMinutes,
      badgeKey: plan.badge,
    };
  }
}
