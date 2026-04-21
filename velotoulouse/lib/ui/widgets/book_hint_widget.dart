import 'package:flutter/material.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class BookHintWidget extends StatelessWidget {
  const BookHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Text(
            'Click on a bike to book',
            style: AppTextStyles.body.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.ads_click, color: AppColors.primary, size: 18),
        ],
      ),
    );
  }
}
