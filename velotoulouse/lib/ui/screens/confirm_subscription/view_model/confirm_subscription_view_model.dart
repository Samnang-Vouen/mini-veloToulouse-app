import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class ConfirmSubscriptionViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final UserState _userState;

  bool isSubscribing = false;

  ConfirmSubscriptionViewModel({
    required UserRepository userRepository,
    required UserState userState,
  }) : _userRepository = userRepository,
       _userState = userState;

  Future<bool> subscribe(SubscriptionPlan plan) async {
    isSubscribing = true;
    notifyListeners();

    try {
      await _userRepository.subscribe(plan);
      // Refresh global state so every listening screen is immediately updated.
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
