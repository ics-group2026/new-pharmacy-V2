import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/features/auth/data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserModel? user;

  String get _initials {
    final first = user?.firstName.trim() ?? '';
    final last = user?.lastName.trim() ?? '';
    final buffer = StringBuffer();
    if (first.isNotEmpty) buffer.write(first[0]);
    if (last.isNotEmpty) buffer.write(last[0]);
    return buffer.toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 88.r,
          height: 88.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryContainer,
          ),
          child: _initials.isEmpty
              ? Icon(Icons.person_rounded, size: 44.r, color: AppColors.primary)
              : Text(
                  _initials,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        SizedBox(height: 12.h),
        if (user != null) ...[
          Text(
            '${user!.firstName} ${user!.lastName}'.trim(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            user!.email,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}