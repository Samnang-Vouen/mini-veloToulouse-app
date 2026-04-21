import 'package:flutter/material.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class StationHeaderWidget extends StatelessWidget {
  final Station station;
  final int? availableBikesOverride;

  const StationHeaderWidget({
    super.key,
    required this.station,
    this.availableBikesOverride,
  });

  @override
  Widget build(BuildContext context) {
    final bikeCount = availableBikesOverride ?? station.availableBikes;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  station.streetName,
                  style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
                ),
                const SizedBox(height: 4),
                Text(
                  '$bikeCount bike${bikeCount == 1 ? '' : 's'} available',
                  style: AppTextStyles.label.copyWith(
                    color: bikeCount > 0
                        ? AppColors.primary
                        : AppColors.disabled,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
