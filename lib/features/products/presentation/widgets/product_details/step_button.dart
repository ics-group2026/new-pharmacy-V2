import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepButton extends StatelessWidget {
  const StepButton({super.key, required this.icon, required this.onTap, required this.colorScheme});

  final IconData icon;
  final VoidCallback? onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: enabled ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          size: 20.r,
          color: enabled ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}