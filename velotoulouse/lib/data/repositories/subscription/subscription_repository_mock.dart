import 'package:velotoulouse/data/dummy_data.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {
  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DummyData.plans;
  }

  @override
  Future<void> updatePlan(SubscriptionPlan plan) async {
    await Future.delayed(const Duration(microseconds: 300));
  }
}
