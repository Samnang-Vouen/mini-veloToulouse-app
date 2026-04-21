import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/ui/screens/plan_detail/plan_detail_screen.dart';
import 'package:velotoulouse/ui/screens/subscription/view%20modal/subscription_view_modal.dart';
import 'package:velotoulouse/ui/theme/theme.dart';
import 'package:velotoulouse/ui/widgets/subscription_plan_card.dart';
import 'package:velotoulouse/ui/widgets/switch_cancel_modal.dart';

class SubscriptionContent extends StatelessWidget {
  final VoidCallback? onBack;

  const SubscriptionContent({super.key, this.onBack});

  void _showSwitchCancelModal(BuildContext context, SubscriptionViewModel vm) {
    final active = vm.activeSubscription!;
    final otherPlans = vm.plans.where((p) => p.id != active.plan.id).toList();

    showDialog(
      context: context,
      builder: (_) => SwitchCancelModal(
        activePlan: active.plan,
        otherPlans: otherPlans,
        onConfirm: (cancel, switchTo) async {
          if (cancel) {
            await vm.cancelSubscription();
          } else if (switchTo != null) {
            await vm.switchSubscription(switchTo);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SubscriptionViewModel>();

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAlt,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: Text(
          'Subscriptions pass',
          style: AppTextStyles.heading.copyWith(color: AppColors.textDark),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: AppColors.primary),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.s),
          _StatusSubtitle(),
          const SizedBox(height: AppSpacing.xl),
          Expanded(child: _buildBody(context, vm)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, SubscriptionViewModel vm) {
    if (vm.plansValue.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.plansValue.isError) {
      return const Center(child: Text('Failed to load plans.'));
    }

    final activePlanId = vm.activeSubscription?.plan.id;
    final hasActive = activePlanId != null;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      itemCount: vm.plans.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.m),
      itemBuilder: (context, index) {
        final plan = vm.plans[index];
        final isActive = plan.id == activePlanId;
        final isDisabled = hasActive && !isActive;

        return SubscriptionPlanCard(
          plan: plan,
          isActive: isActive,
          isDisabled: isDisabled,
          onTap: isDisabled
              ? null
              : () async {
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlanDetailScreen(plan: plan),
                    ),
                  );
                  // No manual reload needed: ConfirmSubscriptionViewModel
                  // calls UserState.refreshSubscription() on success, which
                  // automatically notifies SubscriptionViewModel.
                },
          onSwitchCancel: isActive
              ? () => _showSwitchCancelModal(context, vm)
              : null,
        );
      },
    );
  }
}

class _StatusSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SubscriptionViewModel>();
    final active = vm.activeSubscription;

    if (active != null && active.isActive) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.body.copyWith(color: AppColors.textDark),
          children: [
            const TextSpan(text: 'You are subscribing to '),
            TextSpan(
              text: active.plan.name,
              style: const TextStyle(color: AppColors.primary),
            ),
            const TextSpan(text: ' plan '),
            TextSpan(
              text: active.formattedEndLabel,
              style: const TextStyle(color: AppColors.primary),
            ),
          ],
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.body.copyWith(color: AppColors.textDark),
        children: const [
          TextSpan(text: 'You are currently '),
          TextSpan(
            text: 'not subscribing',
            style: TextStyle(color: AppColors.primary),
          ),
          TextSpan(text: ' to '),
          TextSpan(
            text: 'any plans',
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
