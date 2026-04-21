import 'package:flutter/material.dart';
import 'package:velotoulouse/model/docks/dock.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class DockBookingModal extends StatefulWidget {
  final Dock dock;
  final UserSubscription? activeSubscription;
  final VoidCallback onConfirm;
  final VoidCallback onSelectPass;

  const DockBookingModal({
    super.key,
    required this.dock,
    required this.activeSubscription,
    required this.onConfirm,
    required this.onSelectPass,
  });

  @override
  State<DockBookingModal> createState() => _DockBookingModalState();
}

class _DockBookingModalState extends State<DockBookingModal> {
  bool _confirmed = false;

  bool get _hasSubscription =>
      widget.activeSubscription != null && widget.activeSubscription!.isActive;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      backgroundColor: AppColors.background,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.l,
              AppSpacing.xl,
              AppSpacing.l,
              AppSpacing.l,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon — changes on confirm
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _confirmed
                        ? const Color(0xFFE6F4EA)
                        : AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _confirmed ? Icons.check_rounded : Icons.directions_bike,
                    color: _confirmed ? Colors.green : AppColors.primary,
                    size: 44,
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // Title on success
                if (_confirmed) ...[
                  Text(
                    'BOOKING CONFIRMED!',
                    style: AppTextStyles.title.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                ],

                // Info rows
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textDark,
                        ),
                        children: [
                          const TextSpan(text: 'Subscription: '),
                          TextSpan(
                            text: _hasSubscription
                                ? widget.activeSubscription!.plan.name
                                : 'No Pass',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textDark,
                        ),
                        children: [
                          const TextSpan(text: 'Dock: '),
                          TextSpan(
                            text: widget.dock.id,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.l),

                // Button or close hint
                if (_confirmed)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radius,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.m,
                        ),
                      ),
                      child: Text(
                        'CLOSE',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_hasSubscription) {
                          setState(() => _confirmed = true);
                          widget.onConfirm();
                        } else {
                          Navigator.of(context).pop();
                          widget.onSelectPass();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radius,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.m,
                        ),
                      ),
                      child: Text(
                        _hasSubscription ? 'CONFIRM' : 'SELECT PASS',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: AppSpacing.s,
            right: AppSpacing.s,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
