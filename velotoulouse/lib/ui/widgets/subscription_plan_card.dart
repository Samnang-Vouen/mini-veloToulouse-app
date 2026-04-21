import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback? onTap;
  final VoidCallback? onSwitchCancel;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    this.isActive = false,
    this.isDisabled = false,
    this.onTap,
    this.onSwitchCancel,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDisabled ? AppColors.cardDisabled : Colors.white;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.l,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: AppTextStyles.priceMedium.copyWith(
                      color: isDisabled
                          ? AppColors.textGrey
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    plan.formattedPrice,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 16,
                      color: isDisabled
                          ? AppColors.textGrey
                          : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive) ...[
              GestureDetector(
                onTap: onSwitchCancel,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.m,
                    vertical: AppSpacing.xs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Switch or Cancel Plan',
                    style: AppTextStyles.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
            ],
            Icon(
              Icons.chevron_right,
              color: isDisabled ? AppColors.textGrey : AppColors.textGrey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
