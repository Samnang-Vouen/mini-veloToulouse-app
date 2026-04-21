import 'package:flutter/material.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

enum _SwitchCancelChoice { cancel, switchPlan }

class SwitchCancelModal extends StatefulWidget {
  final SubscriptionPlan activePlan;
  final List<SubscriptionPlan> otherPlans;
  final Future<void> Function(bool cancel, SubscriptionPlan? switchTo)
  onConfirm;

  const SwitchCancelModal({
    super.key,
    required this.activePlan,
    required this.otherPlans,
    required this.onConfirm,
  });

  @override
  State<SwitchCancelModal> createState() => _SwitchCancelModalState();
}

class _SwitchCancelModalState extends State<SwitchCancelModal> {
  _SwitchCancelChoice _choice = _SwitchCancelChoice.cancel;
  SubscriptionPlan? _selectedSwitchPlan;
  bool _loading = false;

  bool get _canConfirm =>
      _choice == _SwitchCancelChoice.cancel ||
      (_choice == _SwitchCancelChoice.switchPlan &&
          _selectedSwitchPlan != null);

  Future<void> _confirm() async {
    setState(() => _loading = true);
    await widget.onConfirm(
      _choice == _SwitchCancelChoice.cancel,
      _choice == _SwitchCancelChoice.switchPlan ? _selectedSwitchPlan : null,
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Switch or Cancel Plan Confirmation',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleBold.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.m),
            // Cancel Plan tile
            _ChoiceTile(
              title: 'Cancel Plan',
              subtitle: 'Your time and Paid Fee is Dismissed',
              selected: _choice == _SwitchCancelChoice.cancel,
              onTap: () => setState(() {
                _choice = _SwitchCancelChoice.cancel;
                _selectedSwitchPlan = null;
              }),
            ),
            const SizedBox(height: AppSpacing.s),
            // Switch Plan tile
            _ChoiceTile(
              title: 'Switch Plan',
              subtitle:
                  'You can continue with your remained time but remained fee is Non-Refundable.',
              selected: _choice == _SwitchCancelChoice.switchPlan,
              onTap: () =>
                  setState(() => _choice = _SwitchCancelChoice.switchPlan),
              children: _choice == _SwitchCancelChoice.switchPlan
                  ? widget.otherPlans
                        .map(
                          (p) => _PlanRadioTile(
                            plan: p,
                            selected: _selectedSwitchPlan?.id == p.id,
                            onTap: () =>
                                setState(() => _selectedSwitchPlan = p),
                          ),
                        )
                        .toList()
                  : null,
            ),
            const SizedBox(height: AppSpacing.l),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _loading
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                ElevatedButton(
                  onPressed: (_canConfirm && !_loading) ? _confirm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radius),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.l,
                      vertical: AppSpacing.s,
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Confirm',
                          style: AppTextStyles.button.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final List<Widget>? children;

  const _ChoiceTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.s,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.titleBold.copyWith(
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Radio<bool>(
                    value: true,
                    // ignore: deprecated_member_use
                    groupValue: selected,
                    // ignore: deprecated_member_use
                    onChanged: (_) => onTap(),
                    activeColor: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
            if (children != null) ...[
              const Divider(height: 1, thickness: 1),
              ...children!,
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanRadioTile extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool selected;
  final VoidCallback onTap;

  const _PlanRadioTile({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.xs,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${plan.name} - ${plan.price}\$ / ${plan.period}',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Radio<bool>(
              value: true,
              // ignore: deprecated_member_use
              groupValue: selected,
              // ignore: deprecated_member_use
              onChanged: (_) => onTap(),
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
