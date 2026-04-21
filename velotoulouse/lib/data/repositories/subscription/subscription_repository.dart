import 'package:velotoulouse/model/subscription/subscription_plan.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionPlan>> getPlans();
  Future<void> updatePlan(SubscriptionPlan plan);
}
