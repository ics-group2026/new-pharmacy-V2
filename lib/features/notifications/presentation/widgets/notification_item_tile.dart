import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/notification_model.dart';

class NotificationItemTile extends StatelessWidget {
  const NotificationItemTile({super.key, required this.notification, this.onTap});

  final NotificationModel notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final languageCode = context.locale.languageCode;
    final title = notification.notification?.title.localized(languageCode) ?? '';
    final body = notification.notification?.body.localized(languageCode) ?? '';
    final createdAt = notification.createdAt;
    final isRead = notification.isRead;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isRead ? colorScheme.surface : colorScheme.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: colorScheme.primary,
                size: 20.r,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (createdAt != null) ...[
                    6.verticalSpace,
                    Text(
                      DateFormat(
                        'MMM d, hh:mm a',
                        context.locale.toString(),
                      ).format(createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isRead) ...[
              8.horizontalSpace,
              Container(
                width: 8.r,
                height: 8.r,
                margin: EdgeInsets.only(top: 4.h),
                decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
