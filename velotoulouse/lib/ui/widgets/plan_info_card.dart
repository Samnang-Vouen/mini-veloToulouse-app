import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class PlanInfoCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onChoose;

  const PlanInfoCard({super.key, required this.plan, required this.onChoose});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (plan.badge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                plan.badge!,
                style: AppTextStyles.caption.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
          ],
          // Bike icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            ),
            child: const Icon(
              Icons.directions_bike,
              color: AppColors.primary,
              size: 38,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          // Plan name
          Text(
            plan.name,
            style: AppTextStyles.headingHeavy.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          // Price
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '€${plan.price}',
                  style: AppTextStyles.price.copyWith(color: AppColors.primary),
                ),
                TextSpan(
                  text: ' / ${plan.period}',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          // Free ride row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, color: AppColors.primary, size: 18),
              const SizedBox(width: AppSpacing.s),
              Text(
                '${plan.freeRideLabel} of your ride is FREE',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          // CHOOSE PASS button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onChoose,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                elevation: 0,
              ),
              child: Text(
                'CHOOSE PASS',
                style: AppTextStyles.button.copyWith(
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
