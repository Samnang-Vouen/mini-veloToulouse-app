import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/model/user/user.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

class UserRepositoryMock implements UserRepository {
  UserSubscription? _activeSubscription;

  @override
  Future<User?> getUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return User(
      id: 'user_001',
      email: 'demo@velotoulouse.com',
      subscription: _activeSubscription,
    );
  }

  @override
  Future<UserSubscription?> getActiveSubscription() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _activeSubscription;
  }

  @override
  Future<void> subscribe(SubscriptionPlan plan) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _activeSubscription = UserSubscription(
      plan: plan,
      startDate: DateTime.now(),
      bonusDuration: plan.bonusDuration,
    );
  }

  @override
  Future<void> switchSubscription(
    SubscriptionPlan plan,
    Duration bonusDuration,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _activeSubscription = UserSubscription(
      plan: plan,
      startDate: DateTime.now(),
      bonusDuration: bonusDuration,
    );
  }

  @override
  Future<void> cancelSubscription() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _activeSubscription = null;
  }
}
