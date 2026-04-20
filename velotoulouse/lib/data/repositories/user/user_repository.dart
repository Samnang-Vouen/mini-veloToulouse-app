import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/model/user/user.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Future<UserSubscription?> getActiveSubscription();
  Future<void> subscribe(SubscriptionPlan plan);
  Future<void> switchSubscription(
    SubscriptionPlan plan,
    Duration bonusDuration,
  );
  Future<void> cancelSubscription();
}
