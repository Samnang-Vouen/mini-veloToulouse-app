import 'package:velotoulouse/data/dto/subscription_plan_dto.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

class UserSubscriptionDto {
  static final String planKey = 'plan';
  static final String startDateKey = 'startDate';
  static final String bonusDurationSecondsKey = 'bonusDurationSeconds';

  static UserSubscription fromJson(Map<String, dynamic> json) {
    assert(json[planKey] is Map<String, dynamic>);
    assert(json[startDateKey] is String);

    final planJson = json[planKey] as Map<String, dynamic>;

    return UserSubscription(
      plan: SubscriptionPlanDto.fromJson(planJson['id'] as String, planJson),
      startDate: DateTime.parse(json[startDateKey] as String),
      bonusDuration: Duration(
        seconds: json[bonusDurationSecondsKey] as int? ?? 0,
      ),
    );
  }

  Map<String, dynamic> toJson(UserSubscription sub) {
    final planMap = SubscriptionPlanDto().toJson(sub.plan);
    planMap['id'] = sub.plan.id;
    return {
      planKey: planMap,
      startDateKey: sub.startDate.toIso8601String(),
      bonusDurationSecondsKey: sub.bonusDuration.inSeconds,
    };
  }
}
