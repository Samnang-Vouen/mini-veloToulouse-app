import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/screens/plan_detail/widgets/plan_detial_content.dart';

class PlanDetailScreen extends StatelessWidget {
  final SubscriptionPlan plan;

  const PlanDetailScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return PlanDetailContent(plan: plan);
  }
}
