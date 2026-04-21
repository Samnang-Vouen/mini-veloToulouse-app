import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class SubscriptionSummaryCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionSummaryCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: label + plan name + bike icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SELECTED PLAN',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      plan.name,
                      style: AppTextStyles.headingHeavy.copyWith(
                        fontSize: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radius),
                ),
                child: const Icon(
                  Icons.directions_bike,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: AppSpacing.m),
          _DetailRow(label: 'Duration', value: plan.duration),
          const SizedBox(height: AppSpacing.s),
          _DetailRow(
            label: plan.freeRideLabel,
            value: 'Free',
            valueColor: Colors.green,
          ),
          const SizedBox(height: AppSpacing.m),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: AppSpacing.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total pay',
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '€${plan.price}',
                style: AppTextStyles.priceMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
        ),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            color: valueColor ?? AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
