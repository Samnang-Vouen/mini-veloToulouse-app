import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/screens/confirm_subscription/view_model/confirm_subscription_view_model.dart';
import 'package:velotoulouse/ui/theme/theme.dart';
import 'package:velotoulouse/ui/widgets/subscription_summary_card.dart';

class ConfirmSubscriptionContent extends StatelessWidget {
  final SubscriptionPlan plan;

  const ConfirmSubscriptionContent({super.key, required this.plan});

  Future<void> _onConfirm(BuildContext context) async {
    final vm = context.read<ConfirmSubscriptionViewModel>();
    final success = await vm.subscribe(plan);
    if (!context.mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subscription failed. Please try again.')),
      );
    }
  }

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
          'Confirm your subscription',
          style: AppTextStyles.titleBold.copyWith(color: AppColors.textDark),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.m),
            SubscriptionSummaryCard(plan: plan),
            const SizedBox(height: AppSpacing.l),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.label.copyWith(color: AppColors.textGrey),
                children: const [
                  TextSpan(text: 'By subscribing, you agree to our '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                        '. Your subscription will automatically renew at the end of each period.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.m,
          AppSpacing.s,
          AppSpacing.m,
          AppSpacing.l,
        ),
        child: Builder(
          builder: (context) {
            final isSubscribing = context
                .watch<ConfirmSubscriptionViewModel>()
                .isSubscribing;
            return ElevatedButton(
              onPressed: isSubscribing ? null : () => _onConfirm(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                elevation: 0,
              ),
              child: isSubscribing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Confirm and subscribe',
                      style: AppTextStyles.button.copyWith(color: Colors.white),
                    ),
            );
          },
        ),
      ),
    );
  }
}
