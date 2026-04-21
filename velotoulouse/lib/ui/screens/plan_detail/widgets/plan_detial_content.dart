import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/screens/confirm_subscription/confirm_subscription_screen.dart';
import 'package:velotoulouse/ui/theme/theme.dart';
import 'package:velotoulouse/ui/widgets/plan_info_card.dart';

class PlanDetailContent extends StatelessWidget {
  final SubscriptionPlan plan;

  const PlanDetailContent({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          plan.name,
          style: AppTextStyles.headingHeavy.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: AppColors.primary),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
          child: PlanInfoCard(
            plan: plan,
            onChoose: () async {
              final confirmed = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmSubscriptionScreen(plan: plan),
                ),
              );
              if (confirmed == true && context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
          ),
        ),
      ),
    );
  }
}
