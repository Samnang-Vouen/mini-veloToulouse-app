import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';
import 'package:velotoulouse/ui/states/user_state.dart';
import 'package:velotoulouse/ui/utils/async_value.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final SubscriptionRepository _repository;
  final UserRepository _userRepository;
  final UserState _userState;

  AsyncValue<List<SubscriptionPlan>> plansValue = AsyncValue.loading();
  bool isSubscribing = false;

  List<SubscriptionPlan> get plans => plansValue.data ?? [];

  UserSubscription? get activeSubscription => _userState.user?.subscription;

  SubscriptionViewModel({
    required SubscriptionRepository subscriptionRepository,
    required UserRepository userRepository,
    required UserState userState,
  }) : _repository = subscriptionRepository,
       _userRepository = userRepository,
       _userState = userState {

    _userState.addListener(notifyListeners);
    loadPlans();
  }

  @override
  void dispose() {
    _userState.removeListener(notifyListeners);
    super.dispose();
  }

  Future<void> loadPlans() async {
    plansValue = AsyncValue.loading();
    notifyListeners();

    try {
      final plans = await _repository.getPlans();
      plansValue = AsyncValue.success(plans);
    } catch (e) {
      plansValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<bool> subscribe(SubscriptionPlan plan) async {
    isSubscribing = true;
    notifyListeners();

    try {
      await _userRepository.subscribe(plan);
      await _userState.refreshSubscription();
      return true;
    } catch (_) {
      return false;
    } finally {
      isSubscribing = false;
      notifyListeners();
    }
  }

  Future<bool> cancelSubscription() async {
    isSubscribing = true;
    notifyListeners();

    try {
      await _userRepository.cancelSubscription();
      await _userState.refreshSubscription();
      return true;
    } catch (_) {
      return false;
    } finally {
      isSubscribing = false;
      notifyListeners();
    }
  }

  Future<bool> updatePlan(SubscriptionPlan plan) async {
    try {
      await _repository.updatePlan(plan);
      await loadPlans();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> switchSubscription(SubscriptionPlan plan) async {
    isSubscribing = true;
    notifyListeners();

    try {
      final now = DateTime.now();
      final remaining =
          (activeSubscription != null &&
              activeSubscription!.endDate.isAfter(now))
          ? activeSubscription!.endDate.difference(now)
          : Duration.zero;
      await _userRepository.switchSubscription(plan, remaining);
      await _userState.refreshSubscription();
      return true;
    } catch (_) {
      return false;
    } finally {
      isSubscribing = false;
      notifyListeners();
    }
  }
}
