import 'package:flutter/material.dart';
import 'package:velotoulouse/model/docks/dock.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class DockListItemWidget extends StatelessWidget {
  final Dock dock;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback onTap;
  final VoidCallback? onCancel;

  const DockListItemWidget({
    super.key,
    required this.dock,
    required this.isSelected,
    this.isBooked = false,
    required this.onTap,
    this.onCancel,
  });

  static const Color _bookedGreen = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    // A booked dock is treated as if it has no bike — unavailable to everyone.
    final hasBike = dock.bike.isNotEmpty && !isBooked;
    final Color borderColor = isSelected
        ? AppColors.primary
        : AppColors.divider;
    final Color idColor = isSelected ? AppColors.primary : AppColors.textDark;

    return GestureDetector(
      onTap: hasBike ? onTap : null,
      child: Container(
        color: isSelected ? AppColors.primaryLight : AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  dock.id,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w600,
                    color: idColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.directions_bike,
              size: 28,
              color: hasBike ? AppColors.textDark : AppColors.disabled,
            ),
            if (isBooked) ...[
              const SizedBox(width: 8),
              Text(
                'Your booking',
                style: AppTextStyles.label.copyWith(
                  color: _bookedGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onCancel,
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
