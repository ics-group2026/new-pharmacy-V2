import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, 
    required this.icon,
    required this.titleKey,
    required this.onTap,
  });

  final IconData icon;
  final String titleKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, size: 20.r, color: colorScheme.primary),
      ),
      title: TText(
        titleKey,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14.r,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
      ),
    );
  }
}