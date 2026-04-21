import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velotoulouse/data/config/firebase_config.dart';
import 'package:velotoulouse/data/dto/subscription_plan_dto.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';

class SubscriptionRepositoryReal implements SubscriptionRepository {
  final Uri _plansUri = FirebaseConfig.baseUrl.replace(
    path: '/subscription_plans.json',
  );

  Uri _planUri(String id) =>
      FirebaseConfig.baseUrl.replace(path: '/subscription_plans/$id.json');

  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    final response = await http.get(_plansUri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load subscription plans (HTTP ${response.statusCode})',
      );
    }

    final decoded = jsonDecode(response.body);

    final List<MapEntry<String, dynamic>> entries;
    if (decoded is Map<String, dynamic>) {
      entries = decoded.entries.toList();
    } else if (decoded is List<dynamic>) {
      entries = decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => MapEntry(e['id'] as String, e as dynamic))
          .toList();
    } else {
      throw Exception('Unexpected subscription plans response format');
    }

    return entries
        .map(
          (entry) => SubscriptionPlanDto.fromJson(
            entry.key,
            entry.value as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<void> updatePlan(SubscriptionPlan plan) async {
    final body = jsonEncode(SubscriptionPlanDto().toJson(plan));
    final response = await http.patch(
      _planUri(plan.id),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update subscription plan "${plan.id}" (HTTP ${response.statusCode})',
      );
    }
  }
}
