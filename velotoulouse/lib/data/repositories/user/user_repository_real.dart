import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velotoulouse/data/config/firebase_config.dart';
import 'package:velotoulouse/data/dto/subscription_plan_dto.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/model/user/user.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

class UserRepositoryReal implements UserRepository {
  static const String _userId = 'user_001';

  Uri get _userUri =>
      FirebaseConfig.baseUrl.replace(path: '/users/$_userId.json');

  Uri get _subscriptionUri =>
      FirebaseConfig.baseUrl.replace(path: '/users/$_userId/subscription.json');

  Uri _planUri(String planId) =>
      FirebaseConfig.baseUrl.replace(path: '/subscription_plans/$planId.json');

  @override
  Future<User?> getUser() async {
    final response = await http.get(_userUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load user (HTTP ${response.statusCode})');
    }

    if (response.body == 'null') return null;

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final sub = await getActiveSubscription();

    return User(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      subscription: sub,
    );
  }

  @override
  Future<UserSubscription?> getActiveSubscription() async {
    final subResponse = await http.get(_subscriptionUri);

    if (subResponse.statusCode != 200) {
      throw Exception(
        'Failed to load user subscription (HTTP ${subResponse.statusCode})',
      );
    }

    if (subResponse.body == 'null') return null;

    final subJson = jsonDecode(subResponse.body) as Map<String, dynamic>;
    final planId = subJson['planId'] as String;

    final planResponse = await http.get(_planUri(planId));

    if (planResponse.statusCode != 200) {
      throw Exception(
        'Failed to load subscription plan (HTTP ${planResponse.statusCode})',
      );
    }

    final planJson = jsonDecode(planResponse.body) as Map<String, dynamic>;
    final plan = SubscriptionPlanDto.fromJson(planId, planJson);

    return UserSubscription(
      plan: plan,
      startDate: DateTime.parse(subJson['startDate'] as String),
      bonusDuration: Duration(
        seconds: subJson['bonusDurationSeconds'] as int? ?? 0,
      ),
    );
  }

  @override
  Future<void> subscribe(SubscriptionPlan plan) async {
    await _writeSubscription(plan, plan.bonusDuration);
  }

  @override
  Future<void> switchSubscription(
    SubscriptionPlan plan,
    Duration bonusDuration,
  ) async {
    await _writeSubscription(plan, bonusDuration);
  }

  @override
  Future<void> cancelSubscription() async {
    final response = await http.delete(_subscriptionUri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to cancel subscription (HTTP ${response.statusCode})',
      );
    }
  }

  Future<void> _writeSubscription(
    SubscriptionPlan plan,
    Duration bonusDuration,
  ) async {
    final body = jsonEncode({
      'planId': plan.id,
      'startDate': DateTime.now().toIso8601String(),
      'bonusDurationSeconds': bonusDuration.inSeconds,
    });

    final response = await http.put(
      _subscriptionUri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to save subscription (HTTP ${response.statusCode})',
      );
    }
  }
}
