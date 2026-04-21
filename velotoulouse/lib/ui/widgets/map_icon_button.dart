import 'package:flutter/material.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

class MapIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MapIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textDark, size: 22),
      ),
    );
  }
}
